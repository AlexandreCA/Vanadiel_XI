-----------------------------------
-- Shattering Stars
-----------------------------------
-- Log ID: 3, Quest ID: 132
-- Maat : !pos 8 3 118 243
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS)

quest.reward =
{
    fame     = 80,
    fameArea = xi.fameArea.JEUNO,
    title    = xi.title.STAR_BREAKER,
}

local maatBattlefieldIds =
{
    [xi.zone.BALGAS_DAIS]        = { 101, 102, 103 },
    [xi.zone.CHAMBER_OF_ORACLES] = { 194, 195, 196 },
    [xi.zone.HORLAIS_PEAK]       = {   5,   6,   7 },
    [xi.zone.QUBIA_ARENA]        = { 517, 518, 519 },
    [xi.zone.WAUGHROON_SHRINE]   = {  70,  71,  72 },
}

local maatBattlefieldZone =
{
    onEventFinish =
    {
        [32001] = function(player, csid, option, npc)
            local battlefieldWin = player:getLocalVar('battlefieldWin')

            for _, battlefieldId in ipairs(maatBattlefieldIds[player:getZoneID()]) do
                if battlefieldWin == battlefieldId then
                    local jobId        = player:getMainJob()
                    local maatsCapMask = player:getCharVar('maatsCap')

                    if player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) == xi.questStatus.QUEST_ACCEPTED then
                        npcUtil.giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP)
                        quest:setVar(player, 'Prog', jobId)
                    end

                    if not utils.mask.getBit(maatsCapMask, jobId - 1) then
                        player:setCharVar('maatsCap', utils.mask.setBit(maatsCapMask, jobId - 1, true))
                    end

                    player:addTitle(xi.title.MAAT_MASHER)
                end
            end
        end,
    },
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getMainJob() <= 15 and -- Only the "old" jobs may start this quest.
                player:getMainLvl() >= 66 and
                player:getLevelCap() == 70 and
                xi.settings.main.MAX_LEVEL >= 75
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(92, player:getMainJob())
                end,
            },

            onEventFinish =
            {
                [92] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:getMainJob() <= 15 and
                player:getMainLvl() >= 66
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrade = function(player, npc, trade)
                    local playerJob       = player:getMainJob()
                    local properTestimony = xi.item.WARRIORS_TESTIMONY + playerJob - 1

                    if
                        npcUtil.tradeHasExactly(trade, properTestimony) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return quest:progressEvent(64, playerJob)
                    end
                end,

                onTrigger = function(player, npc)
                    local playerJob = player:getMainJob()

                    if quest:getVar(player, 'Prog') >= 1 then
                        return quest:progressEvent(93) -- Complete quest.
                    elseif quest:getVar(player, 'tradedTestimony') == 0 then
                        return quest:event(91, playerJob) -- Testimony never traded.
                    else
                        return quest:event(63, playerJob) -- Testimony traded at least once.
                    end
                end,
            },

            onEventFinish =
            {
                [64] = function(player, csid, option, npc)
                    quest:setVar(player, 'tradedTestimony', 1)

                    -- Accept teleport.
                    if option == 1 then
                        local mJob = player:getMainJob()
                        if mJob == xi.job.MNK or mJob == xi.job.WHM or mJob == xi.job.SMN then
                            player:setPos(299.316, -123.591, 353.760, 66, 146)
                        elseif mJob == xi.job.WAR or mJob == xi.job.BLM or mJob == xi.job.RNG then
                            player:setPos(-511.459, 159.004, -210.543, 10, 139)
                        elseif mJob == xi.job.PLD or mJob == xi.job.DRK or mJob == xi.job.BRD then
                            player:setPos(-225.146, -24.250, 20.057, 255, 206)
                        elseif mJob == xi.job.RDM or mJob == xi.job.THF or mJob == xi.job.BST then
                            player:setPos(-349.899, 104.213, -260.150, 0, 144)
                        elseif mJob == xi.job.SAM or mJob == xi.job.NIN or mJob == xi.job.DRG then
                            player:setPos(-220.084, -0.645, 4.442, 191, 168)
                        end
                    end
                end,

                [93] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setLevelCap(75)
                        player:messageSpecial(ruludeID.text.YOUR_LEVEL_LIMIT_IS_NOW_75)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status >= xi.questStatus.QUEST_ACCEPTED and
                player:getMainJob() <= 15 and
                player:getMainLvl() >= 66
        end,

        [xi.zone.BALGAS_DAIS]        = maatBattlefieldZone,
        [xi.zone.CHAMBER_OF_ORACLES] = maatBattlefieldZone,
        [xi.zone.HORLAIS_PEAK]       = maatBattlefieldZone,
        [xi.zone.QUBIA_ARENA]        = maatBattlefieldZone,
        [xi.zone.WAUGHROON_SHRINE]   = maatBattlefieldZone,
    },
}

return quest
