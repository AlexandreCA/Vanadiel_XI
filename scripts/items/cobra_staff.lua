-----------------------------------
-- ID: 18614
-- Cobra Staff
-- Enchantment: "Retrace" (Windurst Waters[S])
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WINDURST_WATERS_S, 0, 3)
end

return itemObject
