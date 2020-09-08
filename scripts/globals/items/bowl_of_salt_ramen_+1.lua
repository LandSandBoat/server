-----------------------------------------
-- ID: 6463
-- Item: bowl_of_salt_ramen_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- DEX +6
-- VIT +6
-- AGI +6
-- Accuracy +6% (cap 95)
-- Ranged Accuracy +6% (cap 95)
-- Evasion +6% (cap 95)
-- Resist Slow +15
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6463)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 6)
    target:addMod(tpz.mod.VIT, 6)
    target:addMod(tpz.mod.AGI, 6)
    target:addMod(tpz.mod.FOOD_ACCP, 6)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 95)
    target:addMod(tpz.mod.FOOD_RACCP, 6)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 95)
    -- target:addMod(tpz.mod.FOOD_EVAP, 6)
    -- target:addMod(tpz.mod.FOOD_EVA_CAP, 95)
    target:addMod(tpz.mod.SLOWRES, 15)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 6)
    target:delMod(tpz.mod.VIT, 6)
    target:delMod(tpz.mod.AGI, 6)
    target:delMod(tpz.mod.FOOD_ACCP, 6)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 95)
    target:delMod(tpz.mod.FOOD_RACCP, 6)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 95)
    -- target:delMod(tpz.mod.FOOD_EVAP, 6)
    -- target:delMod(tpz.mod.FOOD_EVA_CAP, 95)
    target:delMod(tpz.mod.SLOWRES, 15)
end
