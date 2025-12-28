-----------------------------------
-- ID: 6601
-- Item: Omelette Sandwich
-- Food Effect: 30minutes, All Races
-----------------------------------
-- HP +11% (Max. 150)
-- VIT +7
-- MND +7
-- Accuracy +11% (Max. 80)
-- DEF +11% (Max. 120)
-- Enmity +4
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
    effect:addMod(xi.mod.FOOD_HP_CAP, 150)
    effect:addMod(xi.mod.VIT, 7)
    effect:addMod(xi.mod.MND, 7)
    effect:addMod(xi.mod.FOOD_ACCP, 11)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 80)
    effect:addMod(xi.mod.FOOD_DEFP, 11)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 120)
    effect:addMod(xi.mod.ENMITY, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
