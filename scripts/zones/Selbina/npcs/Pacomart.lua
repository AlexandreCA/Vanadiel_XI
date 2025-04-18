-----------------------------------
-- Area: Selbina (248)
--  NPC: Pacomart
-- Type: ROV NPC
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.ROV) >= xi.mission.id.rov.FLAMES_OF_PRAYER then
        player:startEvent(179)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 179 and option == 1 then
        player:setPos(0, 0, 0, 0, 252)
    end
end

return entity
