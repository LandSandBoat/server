-----------------------------------
-- ID: 5685
-- Item: rabbit_pie
-- Food Effect: 30minutes, All Races
-----------------------------------
-- Strength 5
-- Vitality 5
-- Attack 25% (caps @ 100)
-- Ranged Attack 25% (caps @ 100)
-- Defense 25% (caps @ 100)
-- Intelligence -2
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
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.VIT, 5)
    effect:addMod(xi.mod.FOOD_ATTP, 25)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 100)
    effect:addMod(xi.mod.FOOD_RATTP, 25)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 100)
    effect:addMod(xi.mod.FOOD_DEFP, 25)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 100)
    effect:addMod(xi.mod.INT, -2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
