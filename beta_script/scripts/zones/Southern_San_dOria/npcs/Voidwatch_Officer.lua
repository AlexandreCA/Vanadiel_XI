-----------------------------------
-- Zone : Southern San d'Oria
-- NPC : Voidwatch Officer
-- Type : NPC for Voidwatch operations
-- Position : (J-9)
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Constants for Voidstone management
local VOIDSTONE_REGEN_TIME = 20 * 60 * 60 -- 20 hours in seconds
local VOIDSTONE_CURRENCY_ID = "VOIDSTONE"

-- Function to handle interaction with the Voidwatch Officer
entity.onTrigger = function(player, npc)
    local currentTime = os.time()
    local lastVoidstoneTime = player:getVar("LAST_VOIDSTONE_TIME") or currentTime
    local timeSinceLastStone = currentTime - lastVoidstoneTime
    local retroactiveStones = math.floor(timeSinceLastStone / VOIDSTONE_REGEN_TIME)

    player:startEvent(3000, player:getCurrency(VOIDSTONE_CURRENCY_ID), retroactiveStones) -- Hypothetical event ID, voidstone count, retroactive stones
end

-- Function to handle event finishes (player choices)
entity.onEventFinish = function(player, csid, option)
    if csid == 3000 then
        local currentTime = os.time()
        local lastVoidstoneTime = player:getVar("LAST_VOIDSTONE_TIME") or currentTime
        local timeSinceLastStone = currentTime - lastVoidstoneTime
        local retroactiveStones = math.floor(timeSinceLastStone / VOIDSTONE_REGEN_TIME)

        if option == 1 and retroactiveStones > 0 then -- Request Voidstones
            player:addCurrency(VOIDSTONE_CURRENCY_ID, retroactiveStones)
            player:setVar("LAST_VOIDSTONE_TIME", currentTime)
        end
    end
end

return entity