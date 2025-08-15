-----------------------------------
-- ID: 6609
-- Item: serving_of_popotoes_con_queso
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 5
-- Mind 5
-- Attack % 20
-- Attack Cap 130
-- Ranged Attack % 20
-- Ranged Attack Cap 130
-- Evasion % 10
-- Evasion Cap 50
-- Magic Evasion % 10
-- Magic Evasion Cap 50
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 5)
    target:addMod(xi.mod.MND, 5)
    target:addMod(xi.mod.FOOD_ATTP, 20)
    target:addMod(xi.mod.FOOD_ATT_CAP, 130)
    target:addMod(xi.mod.FOOD_RATTP, 20)
    target:addMod(xi.mod.FOOD_RATT_CAP, 130)
    --  target:addMod(xi.mod.FOOD_EVAP, 10)
    --  target:addMod(xi.mod.FOOD_EVA_CAP, 50)
    --  target:addMod(xi.mod.FOOD_MEVAP, 10)
    --  target:addMod(xi.mod.FOOD_MEVA_CAP, 50)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 5)
    target:delMod(xi.mod.MND, 5)
    target:delMod(xi.mod.FOOD_ATTP, 20)
    target:delMod(xi.mod.FOOD_ATT_CAP, 130)
    target:delMod(xi.mod.FOOD_RATTP, 20)
    target:delMod(xi.mod.FOOD_RATT_CAP, 130)
    --  target:delMod(xi.mod.FOOD_EVAP, 10)
    --  target:delMod(xi.mod.FOOD_EVA_CAP, 50)
    --  target:delMod(xi.mod.FOOD_MEVAP, 10)
    --  target:delMod(xi.mod.FOOD_MEVA_CAP, 50)
end

return itemObject
