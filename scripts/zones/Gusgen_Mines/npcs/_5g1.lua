-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5g1 (Door B)
-- !pos 20.002 -42.398 -25.499 196
-----------------------------------
local ID = zones[xi.zone.GUSGEN_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        player:messageSpecial(ID.text.LOCK_OTHER_DEVICE)
    end
end

return entity
