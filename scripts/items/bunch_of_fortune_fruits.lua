-----------------------------------
-- ID: 6498
-- Item: Bunch of Fortune Fruits
-- Food Effect: 30Min, All Races
-----------------------------------
-- Charisma +7
-- may have unknown hidden effects
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
    target:addMod(xi.mod.CHR, 7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CHR, 7)
end

return itemObject
