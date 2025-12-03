-----------------------------------
-- ID: 4557
-- Item: steamed_catfish
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 30
-- Magic % 1 (cap 110)
-- Dex 3
-- Intelligence 1
-- Mind -3
-- Earth Res 10
-- Ranged Accuracy +6% (cap 15)
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
    effect:addMod(xi.mod.FOOD_HP, 30)
    effect:addMod(xi.mod.FOOD_MPP, 1)
    effect:addMod(xi.mod.FOOD_MP_CAP, 110)
    effect:addMod(xi.mod.DEX, 3)
    effect:addMod(xi.mod.INT, 1)
    effect:addMod(xi.mod.MND, -3)
    effect:addMod(xi.mod.EARTH_MEVA, 10)
    effect:addMod(xi.mod.FOOD_RACCP, 6)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
