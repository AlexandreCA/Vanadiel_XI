-----------------------------------
-- Onion Rings
--
-- Kohlo-Lakolo, !pos -26.8 -6 190 240
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.ONION_RINGS)

local function timedEvents(player, inTime, outATime)
    local currentTime = VanadielTime()
    local endTime     = quest:getVar(player, 'EndTime')

    if currentTime < endTime then
        return quest:event(inTime)
    else
        return quest:event(outATime)
    end
end

quest.reward =
{
    fame     = 10,
    fameArea = xi.fameArea.WINDURST,
    title    = xi.title.STAR_ONION_BRIGADIER,
}

quest.sections =
{
    -- NOTE
    -- From the moment you speak with Kohlo-Lakolo, if you dont have the Old Ring, a 24 hour time limit will start.
    -- You still need to get the ring, no matter what.

    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.INSPECTORS_GADGET)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMainLvl() >= 5 and
                        player:getFameLevel(xi.fameArea.WINDURST) >= 3 and
                        not quest:getMustZone(player)
                    then
                        if player:hasKeyItem(xi.ki.OLD_RING) then
                            local currentTime = VanadielTime()
                            local endTime     = quest:getVar(player, 'EndTime')

                            if
                                currentTime < endTime and
                                quest:getVar(player, 'Prog') == 1
                            then
                                return quest:progressEvent(430, 0, xi.ki.OLD_RING) -- Quest starting event.
                            else
                                return quest:progressEvent(432, 0, xi.ki.OLD_RING) -- Instant Quest Complete.
                            end
                        else
                            return quest:progressEvent(429) -- Timer start and reminder text.
                        end
                    else
                        return quest:event(422) -- Default text.
                    end
                end,
            },

            onEventFinish =
            {
                [429] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                        quest:setVar(player, 'EndTime', VanadielTime() + xi.vanaTime.DAY) -- Set current quest started variables.
                    end
                end,

                [430] = function(player, csid, option, npc)
                    quest:begin(player)
                end,

                [432] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.OLD_RING)
                        player:setLocalVar('[2][76]mustZone', 1)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepeted. You didn't start with the "Old Ring" Key Item.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    return timedEvents(player, 431, 433)
                end,
            },

            ['Gomada-Vulmada'] =
            {
                onTrigger = function(player, npc)
                    return timedEvents(player, 435, 442)
                end,
            },

            ['Papo-Hopo'] =
            {
                onTrigger = function(player, npc)
                    return timedEvents(player, 434, 441)
                end,
            },

            ['Pichichi'] =
            {
                onTrigger = function(player, npc)
                    return timedEvents(player, 438, 445)
                end,
            },

            ['Pyo_Nzon'] =
            {
                onTrigger = function(player, npc)
                    return timedEvents(player, 436, 443)
                end,
            },

            ['Shanruru'] =
            {
                onTrigger = function(player, npc)
                    return timedEvents(player, 439, 446)
                end,
            },

            ['Yafa_Yaa'] =
            {
                onTrigger = function(player, npc)
                    return timedEvents(player, 437, 444)
                end,
            },

            onEventFinish =
            {
                [433] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.OLD_RING)
                        player:setLocalVar('[2][76]mustZone', 1)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['_6n2'] =
            {
                onTrigger = function(player, npc)
                    local currentTime = VanadielTime()
                    local endTime     = quest:getVar(player, 'EndTime')

                    if currentTime < endTime then
                        return quest:progressEvent(289)
                    end
                end,
            },

            onEventFinish =
            {
                [289] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.OLD_RING)
                        player:setLocalVar('[2][76]mustZone', 1)
                    end
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS) == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.PORT_WINDURST] =
        {
            -- New default texts.
            ['Gomada-Vulmada'] = quest:event(442):replaceDefault(),
            ['Papo-Hopo']      = quest:event(441):replaceDefault(),
            ['Pichichi']       = quest:event(445):replaceDefault(),
            ['Pyo_Nzon']       = quest:event(443):replaceDefault(),
            ['Shanruru']       = quest:event(446):replaceDefault(),
            ['Yafa_Yaa']       = quest:event(444):replaceDefault(),
        },
    },
}

return quest
