-----------------------------------
-- ID: 5156
-- Item: porcupine_pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP 55
-- Strength 6
-- Vitality 2
-- Intelligence -3
-- Mind 3
-- HP recovered while healing 2
-- MP recovered while healing 2
-- Accuracy 5
-- Attack % 18 (cap 95)
-- Ranged Attack % 18 (cap 95)
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
    effect:addMod(xi.mod.FOOD_HP, 55)
    effect:addMod(xi.mod.STR, 6)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.INT, -3)
    effect:addMod(xi.mod.MND, 3)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 2)
    effect:addMod(xi.mod.ACC, 5)
    effect:addMod(xi.mod.FOOD_ATTP, 18)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 95)
    effect:addMod(xi.mod.FOOD_RATTP, 18)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 95)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
