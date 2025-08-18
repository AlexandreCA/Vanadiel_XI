-----------------------------------
-- ID: 5889
-- Item: stuffed_pitaru
-- Food Effect: 30Min, All Races
-----------------------------------
-- MP +6% (cap 100)
-- Increases rate of magic skill gains by 20%
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 6)
    target:addMod(xi.mod.FOOD_MP_CAP, 100)
    target:addMod(xi.mod.MAGIC_SKILLUP_RATE, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 6)
    target:delMod(xi.mod.FOOD_MP_CAP, 100)
    target:delMod(xi.mod.MAGIC_SKILLUP_RATE, 20)
end

return itemObject
