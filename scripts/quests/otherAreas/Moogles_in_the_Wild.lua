-----------------------------------
-- Moogles in the Wild
-----------------------------------
-- Log ID: 4, Quest ID: 102
-- Moogle : (Mog House, Home Nation)
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MOOGLES_IN_THE_WILD)

quest.reward =
{
    title = xi.title.MOGS_LOVING_MASTER,
}

-- Since there are so many zones with interactions:
quest.sections = {}

quest.sections[1] =
{
    check = function(player, status, vars)
        local bedPlacedTime = quest:getVar(player, 'bedPlacedTime')

        return status == xi.questStatus.QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_MOOGLE_PICNIC) and
            xi.moghouse.isInMogHouseInHomeNation(player) and
            player:getFameLevel(player:getNation()) >= 7 and
            not quest:getMustZone(player) and
            quest:getLocalVar(player, 'questSeen') == 0 and
            bedPlacedTime ~= 0 and
            GetSystemTime() > bedPlacedTime + 60
    end
}

---@type ZoneSection
local questAvailable =
{
    ['Moogle'] =
    {
        onTrigger = function(player, npc)
            return quest:progressEvent(30013, 0, 0, 0, 6, 0, xi.item.RAPTOR_MANTLE, xi.item.WOOL_HAT)
        end,
    },

    onEventFinish =
    {
        [30013] = function(player, csid, option, npc)
            quest:setLocalVar(player, 'questSeen', 1)

            if option == 1 then
                quest:begin(player)
            end
        end,
    },
}

quest.sections[2] =
{
    check = function(player, status, vars)
        return status == xi.questStatus.QUEST_ACCEPTED
    end
}

---@type ZoneSection
local questAccepted =
{
    ['Moogle'] =
    {
        onTrade = function(player, npc, trade)
            if npcUtil.tradeHasExactly(trade, { xi.item.RAPTOR_MANTLE, xi.item.WOOL_HAT }) then
                return quest:progressEvent(30015)
            end
        end,

        onTrigger = function(player, npc)
            local questProgress = quest:getVar(player, 'Prog')
            local questSeen = quest:getLocalVar(player, 'questSeen')

            if questSeen ~= 0 then
                return nil
            end

            if questProgress == 0 then
                return quest:progressEvent(30014, 0, 0, 0, 0, 0, xi.item.RAPTOR_MANTLE, xi.item.WOOL_HAT)
            elseif
                questProgress == 1 and
                quest:getVar(player, 'Timer') < GetSystemTime()
            then
                return quest:progressEvent(30016)
            end
        end,
    },

    onEventFinish =
    {
        [30014] = function(player, csid, option, npc)
            quest:setLocalVar(player, 'questSeen', 1)
        end,

        [30015] = function(player, csid, option, npc)
            player:confirmTrade()
            quest:setVar(player, 'Prog', 1)
            quest:setVar(player, 'Timer', GetSystemTime() + 60)
        end,

        [30016] = function(player, csid, option, npc)
            if quest:complete(player) then
                player:changeContainerSize(xi.inv.MOGSAFE, 10)
                player:changeContainerSize(xi.inv.MOGSAFE2, 10)
            end
        end,
    },
}

for _, zoneId in ipairs(xi.moghouse.moghouseZones) do
    quest.sections[1][zoneId] = questAvailable
    quest.sections[2][zoneId] = questAccepted
end

return quest
