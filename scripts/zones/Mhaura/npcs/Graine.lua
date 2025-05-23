-----------------------------------
-- Area: Mhaura
--  NPC: Graine
-----------------------------------
local ID = zones[xi.zone.MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { 12440,  457, }, -- Leather Bandana
        { 12448,  174, }, -- Bronze Cap
        { 12449, 1700, }, -- Brass Cap
        { 12568,  698, }, -- Leather Vest
        { 12576,  235, }, -- Bronze Harness
        { 12577, 2286, }, -- Brass Harness
        { 12696,  374, }, -- Leather Gloves
        { 12704,  128, }, -- Bronze Mittens
        { 12705, 1255, }, -- Brass Mittens
        { 12824,  557, }, -- Leather Trousesrs
        { 12832,  191, }, -- Bronze Subligar
        { 12833, 1840, }, -- Brass Subligar
        { 12952,  349, }, -- Leather Highboots
        { 12960,  117, }, -- Bronze Leggings
        { 12961, 1140, }, -- Brass Leggings
    }

    player:showText(npc, ID.text.GRAINE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
