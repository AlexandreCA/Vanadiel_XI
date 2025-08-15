-----------------------------------
-- ID: 4532
-- Item: soft-boiled_egg
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 20
-- Magic 20
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HP, 20)
    target:addMod(xi.mod.FOOD_MP, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HP, 20)
    target:delMod(xi.mod.FOOD_MP, 20)
end

return itemObject
