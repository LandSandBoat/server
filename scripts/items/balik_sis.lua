-----------------------------------
-- ID: 5600
-- Item: Balik Sis
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 4
-- Mind -2
-- Attack % 13
-- Attack Cap 65
-- Ranged ACC 1
-- Ranged ATT % 13
-- Ranged ATT Cap 65
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
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.MND, -2)
    effect:addMod(xi.mod.FOOD_ATTP, 13)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 65)
    effect:addMod(xi.mod.RACC, 1)
    effect:addMod(xi.mod.FOOD_RATTP, 13)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 65)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
