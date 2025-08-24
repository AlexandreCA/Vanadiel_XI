-----------------------------------
-- Area: Quicksand Caves
--   NM: Antican Magister
-- Note: https://www.bg-wiki.com/ffxi/Antican_Magister
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    -- Antican Magister is a lottery of various Antica at (C-6).
    --
    [ID.mob.ANTICAN_MAGISTER - 1] = ID.mob.ANTICAN_MAGISTER, -- Antican_Signifer
    [ID.mob.ANTICAN_MAGISTER - 2] = ID.mob.ANTICAN_MAGISTER, -- Antican_Princeps
    [ID.mob.ANTICAN_MAGISTER - 3] = ID.mob.ANTICAN_MAGISTER, -- Antican_Hastatus
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 2100)
    mob:setMobMod(xi.mobMod.GIL_MAX, 4500)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 429)
end

return entity
