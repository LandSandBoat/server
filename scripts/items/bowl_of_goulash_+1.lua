-----------------------------------
-- ID: 5751
-- Item: bowl_of_goulash_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- VIT +4
-- INT -2
-- Accuracy +11% (cap 58)
-- DEF +11% (cap 35)
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.VIT, 4)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.FOOD_ACCP, 11)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 58)
    effect:addMod(xi.mod.FOOD_DEFP, 11)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 35)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
