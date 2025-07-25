-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel MR
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: Allegedly has a 12 hp/sec regen.  Determine if true, and add to onMobInitialize if so.

local function spawnArkAngelPet(mob, target)
    local battlefield = mob:getBattlefield()
    if battlefield then
        local battlefieldId   = battlefield:getID()
        local battlefieldArea = battlefield:getArea()
        local content         = xi.battlefield.contents[battlefieldId]
        local selectedPet     = math.random(1, 2)

        mob:setAutoAttackEnabled(false)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:entityAnimationPacket(xi.animationString.CAST_SUMMONER_START)
        mob:timer(2000, function(mobArg)
            mobArg:entityAnimationPacket(xi.animationString.CAST_SUMMONER_STOP)

            local pet = SpawnMob(content.groups[selectedPet + 1]['mobIds'][battlefieldArea][1])
            if pet then
                battlefield:insertEntity(pet:getTargID(), false, true)

                pet:addListener('DEATH', 'AAMR_PET_DEATH', function(petArg)
                    local petBattlefield = petArg:getBattlefield()

                    petBattlefield:setLocalVar('petRespawnMR', GetSystemTime() + 30)
                end)

                pet:updateEnmity(target)
            end

            mobArg:setAutoAttackEnabled(true)
            mobArg:setMobMod(xi.mobMod.NO_MOVE, 0)
        end)
    end
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.CAN_PARRY, 3)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.PERFECT_DODGE },
        },
    })
end

entity.onMobEngage = function(mob, target)
    spawnArkAngelPet(mob, target)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar('Charm') == 0 and mob:getHPP() < 50 then
        mob:useMobAbility(710)
        mob:setLocalVar('Charm', 1)
    end

    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local respawnTime = battlefield:getLocalVar('petRespawnMR')
    if
        respawnTime ~= 0 and
        respawnTime <= GetSystemTime()
    then
        battlefield:setLocalVar('petRespawnMR', 0)
        spawnArkAngelPet(mob, target)
    end
end

return entity
