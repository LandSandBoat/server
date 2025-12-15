-----------------------------------
-- ID: 6463
-- Item: bowl_of_salt_ramen_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- DEX +6
-- VIT +6
-- AGI +6
-- Accuracy +6% (cap 95)
-- Ranged Accuracy +6% (cap 95)
-- Evasion +6% (cap 95)
-- Resist Slow +15
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
    effect:addMod(xi.mod.DEX, 6)
    effect:addMod(xi.mod.VIT, 6)
    effect:addMod(xi.mod.AGI, 6)
    effect:addMod(xi.mod.FOOD_ACCP, 6)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 95)
    effect:addMod(xi.mod.FOOD_RACCP, 6)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 95)
    -- effect:addMod(xi.mod.FOOD_EVAP, 6)
    -- effect:addMod(xi.mod.FOOD_EVA_CAP, 95)
    effect:addMod(xi.mod.SLOWRES, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
