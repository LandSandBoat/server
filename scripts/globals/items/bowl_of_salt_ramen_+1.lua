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
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6463)
end

item_object.onEffectGain = function(target, effect)
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

item_object.onEffectLose = function(target, effect)
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

return item_object
