-----------------------------------
-- ID: 5669
-- Item: Bowl of Loach Slop
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Make Group Effect
-- Accuracy 7% Cap 15
-- Ranged Accuracy 7% Cap 15
-- HP 7% Cap 15
-- Evasion 3
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
    effect:addMod(xi.mod.FOOD_ACCP, 7)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 15)
    effect:addMod(xi.mod.FOOD_RACCP, 7)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 15)
    effect:addMod(xi.mod.FOOD_HPP, 7)
    effect:addMod(xi.mod.FOOD_HP_CAP, 15)
    effect:addMod(xi.mod.EVA, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
