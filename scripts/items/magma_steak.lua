-----------------------------------
-- ID: 6071
-- Item: Magma Steak
-- Food Effect: 180 Min, All Races
-----------------------------------
-- Strength +8
-- Attack +23% Cap 180
-- Ranged Attack +23% Cap 180
-- Vermin Killer +5
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
    effect:addMod(xi.mod.STR, 8)
    effect:addMod(xi.mod.FOOD_ATTP, 23)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 180)
    effect:addMod(xi.mod.FOOD_RATTP, 23)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 180)
    effect:addMod(xi.mod.VERMIN_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
