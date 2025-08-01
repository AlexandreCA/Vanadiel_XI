-----------------------------------
-- Area: Riverne - Site B01 (BCNM)
-- NM: Bahamut
-- !pos -612.800 1.750 693.190 29
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 20)
    -- should cast a spell every ~30 seconds
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 50)
    -- base damage scaled down from Bahamut v2 (wyrmking decends) value based on level difference
    -- base damage of 136 = (lvl 83 + 2) + 51
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 51)
    -- Note baha has a job trait with fast cast of 15% so 75% total
    mob:setMod(xi.mod.UFASTCAST, 60)
    -- ATT scaled down from Bahamut v2 (wyrmking decends) value based on level difference
    mob:setMod(xi.mod.ATT, 425)
    -- should use mob skill every ~60 sec (without TP feed)
    mob:addMod(xi.mod.REGAIN, 50)
    mob:addMod(xi.mod.REGEN, 50)
    -- MDEF bonus scaled down from Bahamut v2 (wyrmking decends) value based on level difference
    mob:setMod(xi.mod.MDEF, 55)
    mob:addStatusEffect(xi.effect.PHALANX, 35, 0, 180)
    mob:addStatusEffect(xi.effect.STONESKIN, 350, 0, 300)
    mob:addStatusEffect(xi.effect.PROTECT, 175, 0, 1800)
    mob:addStatusEffect(xi.effect.SHELL, 24, 0, 1800)
    -- set these here to make sure no issues if previously killed during a flare mobskill
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setAutoAttackEnabled(true)
end

local megaflareHPP =
{
    90, 80, 70, 60, 50, 40, 30, 20,
}

entity.onMobFight = function(mob, target)
    local megaFlareQueue = mob:getLocalVar('MegaFlareQueue')
    local megaFlareTrigger = mob:getLocalVar('MegaFlareTrigger')
    -- local megaFlareUses = mob:getLocalVar('MegaFlareUses')
    local flareWait = mob:getLocalVar('FlareWait')
    local gigaFlare = mob:getLocalVar('GigaFlare')
    local tauntShown = mob:getLocalVar('tauntShown')
    local mobHPP = mob:getHPP()

    -- if Megaflare hasn't been set to be used this many times, increase the queue of Megaflares. This will allow it to use multiple Megaflares in a row if the HP is decreased quickly enough.
    for trigger, hpp in ipairs(megaflareHPP) do
        if mobHPP < hpp and megaFlareTrigger < trigger then
            mob:setLocalVar('MegaFlareTrigger', trigger)
            mob:setLocalVar('MegaFlareQueue', megaFlareQueue + 1)
            break
        end
    end

    if not xi.combat.behavior.isEntityBusy(mob) then -- the last check prevents multiple Mega/Gigaflares from being called at the same time.
        if megaFlareQueue > 0 then
            mob:setMobAbilityEnabled(false) -- disable all other actions until Megaflare is used successfully
            mob:setMagicCastingEnabled(false)
            mob:setAutoAttackEnabled(false)

            if flareWait == 0 and tauntShown == 0 then -- if there is a queued Megaflare and the last Megaflare has been used successfully or if the first one hasn't been used yet.
                target:showText(mob, ID.text.BAHAMUT_TAUNT)
                mob:setLocalVar('FlareWait', mob:getBattleTime() + 2) -- second taunt happens two seconds after the first.
                mob:setLocalVar('tauntShown', 1)
            elseif flareWait < mob:getBattleTime() and flareWait ~= 0 and tauntShown >= 0 then -- the wait time between the first and second taunt as passed. Checks for wait to be not 0 because it's set to 0 on successful use.
                if tauntShown == 1 then
                    mob:setLocalVar('tauntShown', 2) -- if Megaflare gets stunned it won't show the text again, until successful use.
                    target:showText(mob, ID.text.BAHAMUT_TAUNT + 1)
                end

                if mob:checkDistance(target) <= 15 then -- without this check if the target is out of range it will keep attemping and failing to use Megaflare. Both Megaflare and Gigaflare have range 15.
                    if bit.band(mob:getBehavior(), xi.behavior.NO_TURN) > 0 then -- default behavior
                        mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
                    end

                    mob:useMobAbility(1551)
                end
            end
        elseif
            megaFlareQueue == 0 and
            mobHPP < 10 and
            gigaFlare < 1 and
            mob:checkDistance(target) <= 15
        then
            -- All of the scripted Megaflares are to happen before Gigaflare.
            if tauntShown == 0 then
                target:showText(mob, ID.text.BAHAMUT_TAUNT + 2)
                mob:setLocalVar('tauntShown', 3) -- again, taunt won't show again until the move is successfully used.
            end

            if bit.band(mob:getBehavior(), xi.behavior.NO_TURN) > 0 then -- default behavior
                mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
            end

            mob:useMobAbility(1552)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
