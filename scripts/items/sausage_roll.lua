-----------------------------------
-- ID: 4396
-- Item: sausage_roll
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health % 6 (cap 160)
-- Vitality 3
-- Intelligence -1
-- Attack % 27
-- Attack Cap 30
-- Ranged ATT % 27
-- Ranged ATT Cap 30
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
    effect:addMod(xi.mod.FOOD_HPP, 6)
    effect:addMod(xi.mod.FOOD_HP_CAP, 160)
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.INT, -1)
    effect:addMod(xi.mod.FOOD_ATTP, 27)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 30)
    effect:addMod(xi.mod.FOOD_RATTP, 27)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
