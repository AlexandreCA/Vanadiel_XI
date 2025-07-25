-----------------------------------
-- Forge Your Destiny
-----------------------------------
-- Log ID: 5, Quest ID: 129
-- Jaucribaix      : !pos 91 -7 -8 252
-- Aeka            : !pos 4 0 -4 252
-- Ranemaud        : !pos 15 0 23 252
-- qm2 (Konschtat) : !pos -709 2 102 108
-- qm2 (Zi'Tah)    : !pos 639 -1 -151 121
-----------------------------------
local konschtatID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
local norgID      = zones[xi.zone.NORG]
local zitahID     = zones[xi.zone.THE_SANCTUARY_OF_ZITAH]
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.FORGE_YOUR_DESTINY)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.NORG,
    item = xi.item.MUMEITO,
    title = xi.title.BUSHIDO_BLADE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.NORG] =
        {
            ['Jaucribaix'] = quest:progressEvent(25, xi.item.SACRED_BRANCH, xi.item.LUMP_OF_BOMB_STEEL),

            onEventFinish =
            {
                [25] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['qm2'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.LUMP_OF_ORIENTAL_STEEL) then
                        if player:checkDistance(npc) > 1.6 then
                            return quest:messageSpecial(konschtatID.text.BLACKENED_MUST_BE_CLOSER)
                        elseif
                            GetMobByID(konschtatID.mob.FORGER):isSpawned() or
                            npc:getLocalVar('forgerNextPopAllowedTime') > GetSystemTime()
                        then
                            return quest:messageSpecial(konschtatID.text.BLACKENED_NOTHING_HAPPENS, xi.item.LUMP_OF_ORIENTAL_STEEL)
                        else
                            local forgerMob = SpawnMob(konschtatID.mob.FORGER)
                            if not forgerMob then
                                return quest:noAction()
                            end

                            forgerMob:updateClaim(player)
                            player:confirmTrade()

                            -- QM is visible, but cannot be used to spawn Forger again until two minutes have elapsed
                            -- since the NM despawns.
                            forgerMob:setLocalVar('QMID', npc:getID())
                            forgerMob:addListener('DESPAWN', 'DESPAWN_' .. konschtatID.mob.FORGER, function(mobArg)
                                local qmID = mobArg:getLocalVar('QMID')

                                mobArg:removeListener('DESPAWN_' .. konschtatID.mob.FORGER)
                                GetNPCByID(qmID):setLocalVar('forgerNextPopAllowedTime', GetSystemTime() + 120)
                            end)

                            return quest:messageSpecial(konschtatID.text.PLACE_BLACKENED_SPOT, xi.item.LUMP_OF_ORIENTAL_STEEL)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    if GetMobByID(konschtatID.mob.FORGER):isSpawned() then
                        return quest:messageSpecial(konschtatID.text.NOT_THE_TIME_FOR_THAT)
                    elseif npc:getLocalVar('forgerNextPopAllowedTime') <= GetSystemTime() then
                        -- This message persists even after kill, while the QM is active and quest is accepted.
                        return quest:messageSpecial(konschtatID.text.BLACKENED_SHOULD_PLACE, xi.item.LUMP_OF_ORIENTAL_STEEL)
                    end
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['Aeka'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.CHUNK_OF_DARKSTEEL_ORE) and
                        quest:isVarBitsSet(player, 'Option', 0)
                    then
                        return quest:progressEvent(47, 0, xi.item.LUMP_OF_ORIENTAL_STEEL, xi.item.CHUNK_OF_DARKSTEEL_ORE)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'waitTimer') == 0 then
                        if player:findItem(xi.item.LUMP_OF_BOMB_STEEL) then
                            return quest:progressEvent(48, xi.item.LUMP_OF_BOMB_STEEL)
                        elseif not player:findItem(xi.item.LUMP_OF_ORIENTAL_STEEL) then
                            if not quest:isVarBitsSet(player, 'Option', 0) then
                                return quest:progressEvent(44, xi.item.LUMP_OF_BOMB_STEEL, xi.item.LUMP_OF_ORIENTAL_STEEL)
                            else
                                return quest:progressEvent(46, 0, xi.item.LUMP_OF_ORIENTAL_STEEL, xi.item.CHUNK_OF_DARKSTEEL_ORE)
                            end
                        else
                            return quest:progressEvent(45, xi.item.LUMP_OF_BOMB_STEEL, xi.item.LUMP_OF_ORIENTAL_STEEL)
                        end
                    else
                        return quest:progressEvent(50)
                    end
                end,
            },

            ['Jaucribaix'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.LUMP_OF_BOMB_STEEL, xi.item.SACRED_BRANCH }) then
                        return quest:progressEvent(27)
                    end
                end,

                onTrigger = function(player, npc)
                    local waitTime = quest:getVar(player, 'waitTime')
                    local timeRemaining = waitTime - GetSystemTime()

                    if waitTime == 0 then
                        return quest:progressEvent(26)
                    elseif timeRemaining > 0 then
                        -- Parameter is remaining time in Vana'diel hours.
                        return quest:progressEvent(28, timeRemaining / 144)
                    else
                        return quest:progressEvent(29, xi.item.MUMEITO)
                    end
                end,
            },

            ['Ranemaud'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.item.CHUNK_OF_GOLD_ORE, 2 }, xi.item.CHUNK_OF_PLATINUM_ORE }) and
                        quest:isVarBitsSet(player, 'Option', 1)
                    then
                        return quest:progressEvent(43, 0, 0, xi.item.CHUNK_OF_PLATINUM_ORE, xi.item.CHUNK_OF_GOLD_ORE)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'waitTimer') == 0 then
                        if player:findItem(xi.item.SACRED_BRANCH) then
                            return quest:progressEvent(48, xi.item.SACRED_BRANCH)
                        elseif not player:findItem(xi.item.SACRED_SPRIG) then
                            if not quest:isVarBitsSet(player, 'Option', 1) then
                                return quest:progressEvent(40, xi.item.SACRED_BRANCH, xi.item.SACRED_SPRIG)
                            else
                                return quest:progressEvent(42, 0, xi.item.SACRED_SPRIG, xi.item.CHUNK_OF_PLATINUM_ORE, xi.item.CHUNK_OF_GOLD_ORE)
                            end
                        else
                            return quest:progressEvent(41)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [27] = function(player, csid, option, npc)
                    -- TODO: Add constant for Vana'diel day in seconds, this is a three game day wait.
                    player:confirmTrade()
                    quest:setVar(player, 'waitTime', GetSystemTime() + 10368)
                end,

                [29] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:messageSpecial(norgID.text.YOU_CAN_NOW_BECOME_A_SAMURAI, xi.item.MUMEITO)
                        player:unlockJob(xi.job.SAM)
                    end
                end,

                [40] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.SACRED_SPRIG) then
                        quest:setVarBit(player, 'Option', 1)
                    end
                end,

                [43] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.SACRED_SPRIG) then
                        player:confirmTrade()
                    end
                end,

                [44] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.LUMP_OF_ORIENTAL_STEEL) then
                        quest:setVarBit(player, 'Option', 0)
                    end
                end,

                [47] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.LUMP_OF_ORIENTAL_STEEL) then
                        player:confirmTrade()
                    end
                end,
            },
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            ['Guardian_Treant'] =
            {
                onMobDeath = function(mob, player, optParams)
                    quest:setVar(player, 'Prog', 1)
                end,
            },

            ['qm2'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.HATCHET) and
                        player:hasItem(xi.item.SACRED_SPRIG)
                    then
                        if
                            GetMobByID(zitahID.mob.GUARDIAN_TREANT):isSpawned() or
                            npc:getLocalVar('treantNextPopAllowedTime') > GetSystemTime()
                        then
                            return quest:messageSpecial(zitahID.text.STRANGE_FORCE_PREVENTS)
                        else
                            local treantMob = SpawnMob(zitahID.mob.GUARDIAN_TREANT)
                            if not treantMob then
                                return quest:noAction()
                            end

                            treantMob:updateClaim(player)
                            player:confirmTrade()

                            -- QM is visible, but cannot be used to spawn Forger again until ten minutes have elapsed
                            -- since the NM despawns.
                            treantMob:setLocalVar('QMID', npc:getID())
                            treantMob:addListener('DESPAWN', 'DESPAWN_' .. zitahID.mob.GUARDIAN_TREANT, function(mobArg)
                                local qmID = mobArg:getLocalVar('QMID')

                                mobArg:removeListener('DESPAWN_' .. zitahID.mob.GUARDIAN_TREANT)
                                GetNPCByID(qmID):setLocalVar('treantNextPopAllowedTime', GetSystemTime() + 60 * 10)
                            end)

                            return quest:messageSpecial(zitahID.text.SENSE_STRONG_EVIL_PRESENCE)
                        end
                    elseif
                        npcUtil.tradeHasExactly(trade, xi.item.SACRED_SPRIG) and
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.giveItem(player, xi.item.SACRED_BRANCH)
                    then
                        quest:setVar(player, 'Prog', 2)
                        player:confirmTrade()
                        return quest:messageSpecial(zitahID.text.STRANGE_FORCE_VANISHED, xi.item.SACRED_BRANCH)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if GetMobByID(zitahID.mob.GUARDIAN_TREANT):isSpawned() then
                        return quest:messageSpecial(zitahID.text.NOT_THE_TIME_FOR_THAT)
                    elseif questProgress == 1 then
                        return quest:messageSpecial(zitahID.text.NO_LONGER_SENSE_EVIL)
                    elseif questProgress == 2 then
                        return quest:messageSpecial(zitahID.text.NEWLY_SPROUTED_GLOWING, xi.item.SACRED_SPRIG)
                    elseif npc:getLocalVar('treantNextPopAllowedTime') <= GetSystemTime() then
                        return quest:messageSpecial(zitahID.text.LOOKS_LIKE_STURDY_BRANCH, xi.item.HATCHET)
                    end
                end,
            },
        },
    },
}

return quest
