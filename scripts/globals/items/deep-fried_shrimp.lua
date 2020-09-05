-----------------------------------------
-- ID: 6276
-- Item: deep-fried_shrimp
-- Food Effect: 30Min, All Races
-----------------------------------------
-- VIT +3
-- Fire resistance +20
-- Accuracy +20% (cap 70)
-- Ranged Accuracy +20% (cap 70)
-- Subtle Blow +8
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6276)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.FIRERES, 20)
    target:addMod(tpz.mod.FOOD_ACCP, 20)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 70)
    target:addMod(tpz.mod.FOOD_RACCP, 20)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 70)
    target:addMod(tpz.mod.SUBTLE_BLOW, 8)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.FIRERES, 20)
    target:delMod(tpz.mod.FOOD_ACCP, 20)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 70)
    target:delMod(tpz.mod.FOOD_RACCP, 20)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 70)
    target:delMod(tpz.mod.SUBTLE_BLOW, 8)
end
