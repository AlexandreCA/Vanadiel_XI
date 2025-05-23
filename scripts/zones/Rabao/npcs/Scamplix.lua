-----------------------------------
-- Area: Rabao
--  NPC: Scamplix
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { 4509,    10, }, -- Distilled Waterr
        { 4376,   108, }, -- Meat Jerky
        { 4458,   270, }, -- Goblin Bread
        { 1817,   720, }, -- Cactus Arm
        { 4128,  4348, }, -- Ether
        { 4412,   292, }, -- Thundermelon
        { 4491,   180, }, -- Watermelon
        { 4112,   819, }, -- Potion
        { 4148,   284, }, -- Antidote
        { 4163,  1080, }, -- Blinding Potion
        { 13328, 4050, }, -- Mythril Earring
        { 107,    180, }, -- Water Jug
        { 2868,  9000, }, -- Rabao Waystone
    }

    player:showText(npc, ID.text.SCAMPLIX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
