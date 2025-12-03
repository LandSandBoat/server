-----------------------------------
-- ID: 6602
-- Item: Omelette Sandwich +1
-- Food Effect: 30minutes, All Races
-----------------------------------
-- HP +11% (Max. 155)
-- VIT +8
-- MND +8
-- Accuracy +11% (Max. 85)
-- DEF +11% (Max. 125)
-- Enmity +5
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HPP, 11)
    effect:addMod(xi.mod.FOOD_HP_CAP, 155)
    effect:addMod(xi.mod.VIT, 8)
    effect:addMod(xi.mod.MND, 8)
    effect:addMod(xi.mod.FOOD_ACCP, 11)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 85)
    effect:addMod(xi.mod.FOOD_DEFP, 11)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 125)
    effect:addMod(xi.mod.ENMITY, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
