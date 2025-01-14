-----------------------------------
-- Zone : Bastok Mines
-- NPC : Synergy Engineer
-- Type : NPC for Synergy Crucible 
-- Position : (J-8)
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Constants for Synergy Crucible management
local SYNERGY_CRUCIBLE_KEY_ITEM_ID = 1234 -- Key Item ID for Synergy Crucible
local COST_SYNERGY_CRUCIBLE = 100 -- Coût du Synergy Crucible en gil

-- Function to handle interaction with the Synergy Engineer
entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID) then
        player:startEvent(11001) -- Event to explain Synergy and offer Crucible
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 11001 then
        if option == 1 then -- Player accepts to purchase Synergy Crucible
            if player:getGil() >= COST_SYNERGY_CRUCIBLE then
                player:removeGil(COST_SYNERGY_CRUCIBLE) -- Remove 100 gil
                player:addKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID) -- Give the Synergy Crucible
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.OBTAINED_SYNERGY_CRUCIBLE)
            else
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.NOT_ENOUGH_GIL) -- Message if the player doesn't have enough gil
            end
        end
    end
end

return entity