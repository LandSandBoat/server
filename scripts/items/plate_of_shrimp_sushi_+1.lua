-----------------------------------
-- ID: 5692
-- Item: plate_of_shrimp_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Vitality 2
-- Defense 10
-- Accuracy % 15 (cap 72)
-- Ranged Accuracy % 15 (cap 72)
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
    effect:addMod(xi.mod.DEF, 10)
    effect:addMod(xi.mod.FOOD_ACCP, 15)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 72)
    effect:addMod(xi.mod.FOOD_RACCP, 15)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 72)
    effect:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
