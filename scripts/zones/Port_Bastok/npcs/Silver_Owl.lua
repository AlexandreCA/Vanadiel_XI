-----------------------------------
-- Area: Port Bastok
--  NPC: Silver Owl
-- Type: Tenshodo Merchant
-- !pos -99.155 4.649 23.292 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        if player:sendGuild(60420, 1, 23, 4) then
            player:showText(npc, zones[xi.zone.PORT_BASTOK].text.TENSHODO_SHOP_OPEN_DIALOG)
        end
    end
end

return entity
