-----------------------------------
-- Area: Upper Jeuno
--  NPC: Glyke
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { 4499,   92, }, -- Iron Bread
        { 4408,  128, }, -- Tortilla
        { 4356,  184, }, -- White Bread
        { 4416, 1400, }, -- Pea Soup
        { 4456, 2070, }, -- Boiled Crab
        { 4437,  662, }, -- Roast Mutton
        { 4406,  440, }, -- Baked Apple
        { 4555, 1711, }, -- Windurst Salad
        { 4559, 4585, }, -- Herb Quus
        { 4422,  184, }, -- Orange Juice
        { 4423,  276, }, -- Apple Juice
        { 4442,  368, }, -- Pineapple Juice
        { 4424, 1012, }, -- Mellon Juice
        { 4441,  855, }, -- Grape Juice
    }

    player:showText(npc, ID.text.GLYKE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
