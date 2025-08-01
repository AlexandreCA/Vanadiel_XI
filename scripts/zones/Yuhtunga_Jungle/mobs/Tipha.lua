-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Tipha
-----------------------------------
local ID = zones[xi.zone.YUHTUNGA_JUNGLE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller and GetMobByID(ID.mob.CARTHI):isDead() then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar('cooldown', GetSystemTime() + 900)
    end
end

return entity
