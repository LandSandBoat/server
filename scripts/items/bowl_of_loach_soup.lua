-----------------------------------
-- ID: 5671
-- Item: Bowl of Loach Soup
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- Dexterity 4
-- Agility 4
-- Accuracy 7% Cap 50
-- Ranged Accuracy 7% Cap 50
-- HP 7% Cap 50
-- Evasion 5
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
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.AGI, 4)
    effect:addMod(xi.mod.FOOD_ACCP, 7)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 50)
    effect:addMod(xi.mod.FOOD_RACCP, 7)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 50)
    effect:addMod(xi.mod.FOOD_HPP, 7)
    effect:addMod(xi.mod.FOOD_HP_CAP, 50)
    effect:addMod(xi.mod.EVA, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
