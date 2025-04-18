-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Cermet Portal (Security Gate)
-----------------------------------
local ID = zones[xi.zone.GRAND_PALACE_OF_HUXZOI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() < 520 then
        player:messageSpecial(ID.text.DOES_NOT_RESPOND)
        return
    end

    return -1
end

return entity
