-----------------------------------
-- ID: 4547
-- Item: Bowl of Boiled Cockatrice
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 5
-- Agility 2
-- Intelligence -2
-- Mind 1
-- Attack % 22
-- Attack Cap 60
-- Ranged ATT % 22
-- Ranged ATT Cap 60
-- Resist petrify +4
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
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.MND, 1)
    effect:addMod(xi.mod.FOOD_ATTP, 22)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 60)
    effect:addMod(xi.mod.FOOD_RATTP, 22)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 60)
    effect:addMod(xi.mod.PETRIFYRES, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
