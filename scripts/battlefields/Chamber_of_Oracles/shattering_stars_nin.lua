-----------------------------------
-- Area: Chamber of Oracles
-- Name: Shattering stars - Maat Fight (NIN)
-----------------------------------
local chamberOfOraclesID = zones[xi.zone.CHAMBER_OF_ORACLES]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.CHAMBER_OF_ORACLES,
    battlefieldId = xi.battlefield.id.SHATTERING_STARS_NIN,
    maxPlayers    = 1,
    levelCap      = 99,
    allowSubjob   = false,
    timeLimit     = utils.minutes(10),
    index         = 3,
    entryNpc      = 'SC_Entrance',
    exitNpc       = 'Shimmering_Circle',
    requiredItems = { xi.item.NINJAS_TESTIMONY, wearMessage = chamberOfOraclesID.text.TESTIMONY_WEARS, wornMessage = chamberOfOraclesID.text.TESTIMONY_IS_TORN },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    local jobRequirement   = player:getMainJob() == xi.job.NIN
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
            { chamberOfOraclesID.mob.MAAT + 3 },
            { chamberOfOraclesID.mob.MAAT + 4 },
            { chamberOfOraclesID.mob.MAAT + 5 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
