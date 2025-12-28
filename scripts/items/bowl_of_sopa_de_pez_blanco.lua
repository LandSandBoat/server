-----------------------------------
-- ID: 4601
-- Item: Bowl of Sopa de Pez Blanco
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 12
-- Dexterity 6
-- Mind -4
-- Accuracy 3
-- Ranged ACC % 7
-- Ranged ACC Cap 10
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
    effect:addMod(xi.mod.FOOD_HP, 12)
    effect:addMod(xi.mod.DEX, 6)
    effect:addMod(xi.mod.MND, -4)
    effect:addMod(xi.mod.ACC, 3)
    effect:addMod(xi.mod.FOOD_RACCP, 7)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
