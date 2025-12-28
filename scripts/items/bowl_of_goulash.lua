-----------------------------------
-- ID: 5750
-- Item: bowl_of_goulash
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- VIT +3
-- INT -2
-- Accuracy +10% (cap 54)
-- DEF +10% (cap 30)
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.FOOD_ACCP, 10)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 54)
    effect:addMod(xi.mod.FOOD_DEFP, 10)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
