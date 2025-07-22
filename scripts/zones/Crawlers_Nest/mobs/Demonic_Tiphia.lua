-----------------------------------
-- Area: Crawlers' Nest (197)
--  Mob: Demonic Tiphia
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobFight = function(mob, target)
    -- captures show cure v repeatedly every 15 sec below 50% health
    if
        mob:getHPP() <= 50 and
        not xi.combat.behavior.isEntityBusy(mob) and
        GetSystemTime() > mob:getLocalVar('cureDelay')
    then
        mob:castSpell(xi.magic.spell.CURE_V, mob)
        mob:setLocalVar('cureDelay', GetSystemTime() + 15)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 236)
end

return entity
