-----------------------------------
-- Area: Riverne Site #B01
-- Name: Storms of Fate
-- !pos 299 -123 345 146
-----------------------------------
local riverneID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId        = xi.zone.RIVERNE_SITE_B01,
    battlefieldId = xi.battlefield.id.STORMS_OF_FATE,
    allowTrusts   = true,
    maxPlayers    = 18,
    timeLimit     = utils.minutes(30),
    index         = 0,
    area          = 1,
    entryNpc      = 'Unstable_Displacement',
    exitNpc       = 'SD_BCNM_Exit',
    questArea     = xi.questLog.JEUNO,
    quest         = xi.quest.id.jeuno.STORMS_OF_FATE,
    requiredVar   = 'Quest[3][86]Prog',
    requiredValue = 2,

    title = xi.title.CONQUEROR_OF_FATE,
})

local function healCharacter(player)
    if player:isAlive() then
        player:setHP(player:getMaxHP())
        player:setMP(player:getMaxMP())
        player:setTP(0)

        if player:getPet() ~= nil then
            local pet = player:getPet()
            pet:setHP(pet:getMaxHP())
            pet:setMP(pet:getMaxMP())
            pet:setTP(0)
        end
    end
end

-- players on healed on entry to the battlefield
function content:battlefieldEntry(player, battlefield)
    healCharacter(player)
end

content.groups =
{
    {
        mobIds =
        {
            riverneID.mob.BAHAMUT,
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
