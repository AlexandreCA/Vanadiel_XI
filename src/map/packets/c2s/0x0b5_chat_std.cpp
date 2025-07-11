/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "0x0b5_chat_std.h"

#include "command_handler.h"
#include "common/async.h"
#include "common/database.h"
#include "common/ipc_structs.h"
#include "common/settings.h"
#include "entities/charentity.h"
#include "ipc_client.h"
#include "linkshell.h"
#include "packets/chat_message.h"
#include "packets/message_basic.h"
#include "packets/message_standard.h"
#include "roe.h"
#include "unitychat.h"
#include "utils/jailutils.h"

namespace
{
    const auto auditChat = [](CCharEntity* PChar, const std::string& chatType, const std::string& rawMessage)
    {
        const std::string auditConfigKey = std::format("map.AUDIT_{}", chatType);
        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>(auditConfigKey))
        {
            const auto name   = PChar->getName();
            const auto zoneId = PChar->getZone();

            // clang-format off
            Async::getInstance()->submit([name, chatType, zoneId, rawMessage]()
            {
                const auto query = "INSERT INTO audit_chat (speaker, type, zoneid, message, datetime) VALUES(?, ?, ?, ?, current_timestamp())";
                if (!db::preparedStmt(query, name, chatType, zoneId, rawMessage))
                {
                    ShowErrorFmt("Failed to insert {} audit_chat record for player '{}'", chatType, name);
                }
            });
            // clang-format on
        }
    };

    const auto auditUnity = [](CCharEntity* PChar, const std::string& rawMessage)
    {
        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_UNITY"))
        {
            const auto name        = PChar->getName();
            const auto zoneId      = PChar->getZone();
            const auto unityLeader = PChar->PUnityChat->getLeader();

            // clang-format off
            Async::getInstance()->submit([name, zoneId, unityLeader, rawMessage]()
            {
                const auto query = "INSERT INTO audit_chat (speaker, type, zoneid, unity, message, datetime) VALUES(?, 'UNITY', ?, ?, ?, current_timestamp())";
                if (!db::preparedStmt(query, name, zoneId, unityLeader, rawMessage))
                {
                    ShowError("Failed to insert UNITY audit_chat record for player '%s'", name.c_str());
                }
            });
            // clang-format on
        }
    };

    const auto auditLinkshell = [](CCharEntity* PChar, CLinkshell* PLinkshell, const std::string& rawMessage)
    {
        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_LINKSHELL"))
        {
            const auto name   = PChar->getName();
            const auto zoneId = PChar->getZone();
            char       decodedLinkshellName[DecodeStringLength];
            DecodeStringLinkshell(PLinkshell->getName(), decodedLinkshellName);

            // clang-format off
            Async::getInstance()->submit([name, zoneId, decodedLinkshellName, rawMessage]()
            {
                const auto query = "INSERT INTO audit_chat (speaker, type, lsName, zoneid, message, datetime) VALUES(?, 'LINKSHELL', ?, ?, ?, current_timestamp())";
                if (!db::preparedStmt(query, name, decodedLinkshellName, zoneId, rawMessage))
                {
                    ShowError("Failed to insert LINKSHELL audit_chat record for player '%s'", name);
                }
            });
            // clang-format on
        }
    };
} // namespace

auto GP_CLI_COMMAND_CHAT_STD::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_CHAT_STD_KIND>(Kind);
}

void GP_CLI_COMMAND_CHAT_STD::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Extremely important to figure out the message length here.
    // Depending on alignment, the message may not be NULL-terminated.
    // Start with reported size and skip the first 6 bytes (4x header + 1x kind + 1x unknown).
    const auto messageLength              = std::min<std::size_t>((header.size * 4) - 0x6, sizeof(Str));
    const auto rawMessage                 = asStringFromUntrustedSource(Str, messageLength);
    const auto firstChar                  = rawMessage[0];
    const auto rawMessageWithoutFirstChar = rawMessage.substr(1);

    // Handle possible !commands
    if (firstChar == '!' && !jailutils::InPrison(PChar))
    {
        if (CCommandHandler::call(lua, PChar, rawMessageWithoutFirstChar) == 0 || PChar->m_GMlevel > 0)
        {
            // A command was handled OR a GM may have mistyped.
            return;
        }
    }

    // Handle possible GM message broadcast
    if (firstChar == '#' && PChar->m_GMlevel > 0)
    {
        message::send(ipc::ChatMessageServerMessage{
            .senderId   = PChar->id,
            .senderName = PChar->getName(),
            .message    = rawMessageWithoutFirstChar,
            .zoneId     = PChar->getZone(),
            .gmLevel    = PChar->m_GMlevel,
        });

        return;
    }

    // If you're jailed, you can only use /say
    if (jailutils::InPrison(PChar))
    {
        if (Kind == static_cast<uint8_t>(GP_CLI_COMMAND_CHAT_STD_KIND::Say))
        {
            auditChat(PChar, "SAY", rawMessage);
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SAY, rawMessage));
        }
        else
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_IN_THIS_AREA);
        }

        return;
    }

    // Now handle every other chat type
    switch (static_cast<GP_CLI_COMMAND_CHAT_STD_KIND>(Kind))
    {
        case GP_CLI_COMMAND_CHAT_STD_KIND::Say:
        {
            auditChat(PChar, "SAY", rawMessage);
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SAY, rawMessage));
        }
        break;
        case GP_CLI_COMMAND_CHAT_STD_KIND::Emote:
        {
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<CChatMessagePacket>(PChar, MESSAGE_EMOTION, rawMessage));
        }
        break;
        case GP_CLI_COMMAND_CHAT_STD_KIND::Shout:
        {
            auditChat(PChar, "SHOUT", rawMessage);
            PChar->loc.zone->PushPacket(PChar, CHAR_INSHOUT, std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SHOUT, rawMessage));
        }
        break;
        case GP_CLI_COMMAND_CHAT_STD_KIND::Linkshell1:
        {
            if (PChar->PLinkshell1 != nullptr)
            {
                message::send(ipc::ChatMessageLinkshell{
                    .linkshellId = PChar->PLinkshell1->getID(),
                    .senderId    = PChar->id,
                    .senderName  = PChar->getName(),
                    .message     = rawMessage,
                    .zoneId      = PChar->getZone(),
                    .gmLevel     = PChar->m_GMlevel,
                });

                auditLinkshell(PChar, PChar->PLinkshell1, rawMessage);
            }
        }
        break;
        case GP_CLI_COMMAND_CHAT_STD_KIND::Linkshell2:
        {
            if (PChar->PLinkshell2 != nullptr)
            {
                message::send(ipc::ChatMessageLinkshell{
                    .linkshellId = PChar->PLinkshell2->getID(),
                    .senderId    = PChar->id,
                    .senderName  = PChar->getName(),
                    .message     = rawMessage,
                    .zoneId      = PChar->getZone(),
                    .gmLevel     = PChar->m_GMlevel,
                });

                auditLinkshell(PChar, PChar->PLinkshell2, rawMessage);
            }
        }
        break;
        case GP_CLI_COMMAND_CHAT_STD_KIND::Party:
        {
            if (PChar->PParty != nullptr)
            {
                if (PChar->PParty->m_PAlliance)
                {
                    message::send(ipc::ChatMessageAlliance{
                        .allianceId = PChar->PParty->m_PAlliance->m_AllianceID,
                        .senderId   = PChar->id,
                        .senderName = PChar->getName(),
                        .message    = rawMessage,
                        .zoneId     = PChar->getZone(),
                        .gmLevel    = PChar->m_GMlevel,
                    });
                }
                else
                {
                    message::send(ipc::ChatMessageParty{
                        .partyId    = PChar->PParty->GetPartyID(),
                        .senderId   = PChar->id,
                        .senderName = PChar->getName(),
                        .message    = rawMessage,
                        .zoneId     = PChar->getZone(),
                        .gmLevel    = PChar->m_GMlevel,
                    });
                }

                auditChat(PChar, "PARTY", rawMessage);
            }
        }
        break;
        case GP_CLI_COMMAND_CHAT_STD_KIND::Yell:
        {
            const auto yellCooldownTime = settings::get<uint16>("map.YELL_COOLDOWN");
            const auto isYellBanned     = PChar->getCharVar("[YELL]Banned") == 1;
            const auto isInYellCooldown = PChar->getCharVar("[YELL]Cooldown") == 1;

            if (PChar->loc.zone->CanUseMisc(MISC_YELL))
            {
                if (isYellBanned)
                {
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
                }
                else if (!isInYellCooldown)
                {
                    // CharVar will self-expire and set to zero after the cooldown period
                    PChar->setCharVar("[YELL]Cooldown", 1, earth_time::timestamp() + yellCooldownTime);

                    message::send(ipc::ChatMessageYell{
                        .senderId   = PChar->id,
                        .senderName = PChar->getName(),
                        .message    = rawMessage,
                        .zoneId     = PChar->getZone(),
                        .gmLevel    = PChar->m_GMlevel,
                    });

                    auditChat(PChar, "YELL", rawMessage);
                }
                else
                {
                    PChar->pushPacket<CMessageStandardPacket>(PChar, 0, MsgStd::WaitLonger);
                }
            }
            else
            {
                PChar->pushPacket<CMessageStandardPacket>(PChar, 0, MsgStd::CannotHere);
            }
        }
        break;
        case GP_CLI_COMMAND_CHAT_STD_KIND::Unity:
        {
            if (PChar->PUnityChat != nullptr)
            {
                message::send(ipc::ChatMessageUnity{
                    .unityLeaderId = PChar->PUnityChat->getLeader(),
                    .senderId      = PChar->id,
                    .senderName    = PChar->getName(),
                    .message       = rawMessage,
                    .zoneId        = PChar->getZone(),
                    .gmLevel       = PChar->m_GMlevel,
                });

                roeutils::event(ROE_EVENT::ROE_UNITY_CHAT, PChar, RoeDatagram("unityMessage", rawMessage));

                auditUnity(PChar, rawMessage);
            }
        }
        break;
        case GP_CLI_COMMAND_CHAT_STD_KIND::LinkshellPvp:
        {
            // Not implemented
            auditChat(PChar, "BALLISTA", rawMessage);
        }
        break;
        case GP_CLI_COMMAND_CHAT_STD_KIND::AssistJ:
        case GP_CLI_COMMAND_CHAT_STD_KIND::AssistE:
        {
            // Not implemented
            auditChat(PChar, "ASSIST", rawMessage);
        }
        break;
    }

    PChar->m_charHistory.chatsSent++;
}
