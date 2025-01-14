-----------------------------------
-- Zone : Bastok Markets
-- NPC : Synergy Engineer
-- Type : NPC for Synergy Crucible and Training
-- Position : (G-8)
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Constants for Synergy Crucible management
local SYNERGY_CRUCIBLE_KEY_ITEM_ID = 1234 -- Key Item ID for Synergy Crucible

-- Function to handle interaction with the Synergy Engineer
entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID) then
        player:startEvent(7000) -- Event to explain Synergy and offer Crucible
    else
        player:startEvent(7001) -- Event to provide training or other options
    end
end

-- Function to handle event finishes (player choices)
entity.onEventFinish = function(player, csid, option, npc)
    if csid == 7000 and option == 1 then -- Player accepts the Crucible
        player:addKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID)
        player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.OBTAINED_SYNERGY_CRUCIBLE)
    elseif csid == 7001 then
        if option == 1 then -- Player opts for Synergy training
            player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.SYNERGY_TRAINING_RECEIVED)
            -- Additional training logic can be added here
        end
    end
end

return entity
