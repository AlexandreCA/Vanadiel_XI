-----------------------------------
-- ID: 5190
-- Item: dish_of_spaghetti_carbonara
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health % 14
-- Health Cap 175
-- Magic 10
-- Strength 4
-- Vitality 2
-- Intelligence -3
-- Attack % 17
-- Attack Cap 65
-- Store TP 6
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5190)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 14)
    target:addMod(xi.mod.FOOD_HP_CAP, 175)
    target:addMod(xi.mod.FOOD_MP, 10)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.FOOD_ATTP, 17)
    target:addMod(xi.mod.FOOD_ATT_CAP, 65)
    target:addMod(xi.mod.STORETP, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 14)
    target:delMod(xi.mod.FOOD_HP_CAP, 175)
    target:delMod(xi.mod.FOOD_MP, 10)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.FOOD_ATTP, 17)
    target:delMod(xi.mod.FOOD_ATT_CAP, 65)
    target:delMod(xi.mod.STORETP, 6)
end

return itemObject
