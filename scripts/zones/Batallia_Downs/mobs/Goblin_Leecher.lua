-----------------------------------
-- Area: Batallia Downs
--  Mob: Goblin Leecher
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 74, 2, xi.regime.type.FIELDS)
    if
        xi.settings.main.ENABLE_ACP == 1 and
        not player:hasKeyItem(xi.ki.BOWL_OF_BLAND_GOBLIN_SALAD) and
        player:getCurrentMission(xi.mission.log_id.ACP) >= xi.mission.id.acp.THE_ECHO_AWAKENS
    then
        -- Guesstimating 15% chance
        if math.random(1, 100) >= 85 then
            npcUtil.giveKeyItem(player, xi.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
        end
    end
end

return entity
