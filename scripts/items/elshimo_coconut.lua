-----------------------------------
-- ID: 5187
-- Item: elshimo_coconut
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility -1
-- Intelligence -1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5187)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.INT, -1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.INT, -1)
end

return itemObject
