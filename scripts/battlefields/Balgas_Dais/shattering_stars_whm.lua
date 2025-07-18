-----------------------------------
-- Area: Balga's Dais
-- Name: Shattering stars - Maat Fight (WHM)
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.BALGAS_DAIS,
    battlefieldId = xi.battlefield.id.SHATTERING_STARS_WHM,
    maxPlayers    = 1,
    levelCap      = 99,
    allowSubjob   = false,
    timeLimit     = utils.minutes(10),
    index         = 6,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.WHITE_MAGES_TESTIMONY, wearMessage = balgasID.text.TESTIMONY_WEARS, wornMessage = balgasID.text.TESTIMONY_IS_TORN },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    local jobRequirement   = player:getMainJob() == xi.job.WHM
    local levelRequirement = player:getMainLvl() >= 66
    local questStatus      = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS)
    local questRequirement = questStatus == xi.questStatus.QUEST_COMPLETED or (questStatus == xi.questStatus.QUEST_ACCEPTED and player:getCharVar('Quest[3][132]tradedTestimony') == 1)

    return jobRequirement and levelRequirement and questRequirement
end

content.groups =
{
    {
        mobIds =
        {
            { balgasID.mob.MAAT + 3 },
            { balgasID.mob.MAAT + 4 },
            { balgasID.mob.MAAT + 5 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
