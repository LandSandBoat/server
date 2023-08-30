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
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6463)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 6)
    target:addMod(xi.mod.VIT, 6)
    target:addMod(xi.mod.AGI, 6)
    target:addMod(xi.mod.FOOD_ACCP, 6)
    target:addMod(xi.mod.FOOD_ACC_CAP, 95)
    target:addMod(xi.mod.FOOD_RACCP, 6)
    target:addMod(xi.mod.FOOD_RACC_CAP, 95)
    -- target:addMod(xi.mod.FOOD_EVAP, 6)
    -- target:addMod(xi.mod.FOOD_EVA_CAP, 95)
    target:addMod(xi.mod.SLOWRES, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 6)
    target:delMod(xi.mod.VIT, 6)
    target:delMod(xi.mod.AGI, 6)
    target:delMod(xi.mod.FOOD_ACCP, 6)
    target:delMod(xi.mod.FOOD_ACC_CAP, 95)
    target:delMod(xi.mod.FOOD_RACCP, 6)
    target:delMod(xi.mod.FOOD_RACC_CAP, 95)
    -- target:delMod(xi.mod.FOOD_EVAP, 6)
    -- target:delMod(xi.mod.FOOD_EVA_CAP, 95)
    target:delMod(xi.mod.SLOWRES, 15)
end

return itemObject
