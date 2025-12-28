-----------------------------------
-- ID: 6063
-- Item: fruit_parfait
-- Food Effect: 180 Min, All Races
-----------------------------------
-- MP+5% (Upper limit 50)
-- INT+3
-- MND+2
-- CHR+1
-- STR-3
-- MACC+3
-- MAB+6
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
    effect:addMod(xi.mod.FOOD_MPP, 5)
    effect:addMod(xi.mod.FOOD_MP_CAP, 50)
    effect:addMod(xi.mod.INT, 3)
    effect:addMod(xi.mod.MND, 2)
    effect:addMod(xi.mod.CHR, 1)
    effect:addMod(xi.mod.STR, -3)
    effect:addMod(xi.mod.MACC, 3)
    effect:addMod(xi.mod.MATT, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
