-----------------------------------------
-- ID: 5681
-- Item: cupid_chocolate
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- Accuracy +10
-- Ranged Accuracy +10
-- Attack 10
-- Ranged Attack 10
-- Store TP +25
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5681)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ATT, 10)
    target:addMod(tpz.mod.RATT, 10)
    target:addMod(tpz.mod.ACC, 10)
    target:addMod(tpz.mod.RACC, 10)
    target:addMod(tpz.mod.STORETP, 25)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ATT, 10)
    target:delMod(tpz.mod.RATT, 10)
    target:delMod(tpz.mod.ACC, 10)
    target:delMod(tpz.mod.RACC, 10)
    target:delMod(tpz.mod.STORETP, 25)
end
