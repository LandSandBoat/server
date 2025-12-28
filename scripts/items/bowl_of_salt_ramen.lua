-----------------------------------
-- ID: 6462
-- Item: bowl_of_salt_ramen
-- Food Effect: 30Min, All Races
-----------------------------------
-- DEX +5
-- VIT +5
-- AGI +5
-- Accuracy +5% (cap 90)
-- Ranged Accuracy +5% (cap 90)
-- Evasion +5% (cap 90)
-- Resist Slow +10
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
    effect:addMod(xi.mod.DEX, 5)
    effect:addMod(xi.mod.VIT, 5)
    effect:addMod(xi.mod.AGI, 5)
    effect:addMod(xi.mod.FOOD_ACCP, 5)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 90)
    effect:addMod(xi.mod.FOOD_RACCP, 5)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 90)
    -- effect:addMod(xi.mod.FOOD_EVAP, 5)
    -- effect:addMod(xi.mod.FOOD_EVA_CAP, 90)
    effect:addMod(xi.mod.SLOWRES, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
