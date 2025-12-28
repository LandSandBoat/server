-----------------------------------
-- ID: 6072
-- Item: Magma Steak +1
-- Food Effect: 240 Min, All Races
-----------------------------------
-- Strength +9
-- Attack +24% Cap 185
-- Ranged Attack +24% Cap 185
-- Vermin Killer +6
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
    effect:addMod(xi.mod.STR, 9)
    effect:addMod(xi.mod.FOOD_ATTP, 24)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 185)
    effect:addMod(xi.mod.FOOD_RATTP, 24)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 185)
    effect:addMod(xi.mod.VERMIN_KILLER, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
