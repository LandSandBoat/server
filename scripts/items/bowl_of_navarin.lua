-----------------------------------
-- ID: 4439
-- Item: Bowl of Navarin
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health % 3 (cap 130)
-- Strength 3
-- Agility 1
-- Vitality 1
-- Intelligence -1
-- Attack % 27
-- Attack Cap 30
-- Evasion 5
-- Ranged ATT % 27
-- Ranged ATT Cap 30
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
    effect:addMod(xi.mod.FOOD_HPP, 3)
    effect:addMod(xi.mod.FOOD_HP_CAP, 130)
    effect:addMod(xi.mod.STR, 3)
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.VIT, 1)
    effect:addMod(xi.mod.INT, -1)
    effect:addMod(xi.mod.FOOD_ATTP, 27)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 30)
    effect:addMod(xi.mod.EVA, 5)
    effect:addMod(xi.mod.FOOD_RATTP, 27)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
