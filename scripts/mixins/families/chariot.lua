require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.chariot = function(chariotMob)
    chariotMob:addListener('SPAWN', 'CHARIOT_SPAWN', function(mob)
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    end)

    chariotMob:addListener('ENGAGE', 'CHARIOT_ENGAGE', function(mob)
        mob:setLocalVar('turnTime', GetSystemTime())
        mob:setLocalVar('turnDelay', math.random(10, 30))
    end)

    chariotMob:addListener('COMBAT_TICK', 'CHARIOT_COMBAT', function(mob)
        local time = GetSystemTime()

        if time >= mob:getLocalVar('turnTime') then
            -- mob:face() -- We lack a lua function for c++ FaceTarget. TODO: code it.

            mob:setLocalVar('turnTime', time + math.random(10, 30))
        end
    end)
end

return g_mixins.families.chariot
