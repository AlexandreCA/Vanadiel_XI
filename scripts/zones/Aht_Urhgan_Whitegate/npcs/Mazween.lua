-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mazween
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { 4881, 11200, }, -- Scroll of Sleepga
        { 4867, 18720, }, -- Scroll of Sleep II
        { 4829, 25200, }, -- Poison II
        { 4839, 14000, }, -- Bio II
        { 4833,  5160, }, -- Poisonga
        { 4769, 19932, }, -- Stone III
        { 4779, 22682, }, -- Water III
        { 4764, 27744, }, -- Aero III
        { 4754, 33306, }, -- Fire III
        { 4759, 39368, }, -- Blizzard III
        { 4774, 45930, }, -- Thunder III
        { 4883, 27000, }, -- Absorb-TP
        { 4854, 30780, }, -- Drain II
        { 4885, 70560, }, -- Dread Spikes
        { 4886, 44000, }, -- Absorb-ACC
        { 4856, 79800, }, -- Aspir II
    }

    player:showText(npc, ID.text.MAZWEEN_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
