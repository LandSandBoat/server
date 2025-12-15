-----------------------------------
-- ID: 4348
-- Item: mutton_enchilada
-- Food Effect: 60Min, All Races
-----------------------------------
-- Magic 10
-- Strength 3
-- Vitality 1
-- Intelligence -1
-- Attack % 27
-- Attack Cap 35
-- Ranged ATT % 27
-- Ranged ATT Cap 35
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_MP, 10)
    effect:addMod(xi.mod.STR, 3)
    effect:addMod(xi.mod.VIT, 1)
    effect:addMod(xi.mod.INT, -1)
    effect:addMod(xi.mod.FOOD_ATTP, 27)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 35)
    effect:addMod(xi.mod.FOOD_RATTP, 27)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 35)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
