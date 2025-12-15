-----------------------------------
-- ID: 5722
-- Item: plate_of_crab_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Vitality 2
-- Defense 15
-- Accuracy % 14 (cap 68)
-- Resist Sleep +2
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
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.DEF, 15)
    effect:addMod(xi.mod.FOOD_ACCP, 14)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 68)
    effect:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
