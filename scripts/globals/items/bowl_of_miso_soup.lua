-----------------------------------------
-- ID: 6466
-- Item: bowl_of_miso_soup
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP +7% (cap 50)
-- DEX +4
-- AGI +4
-- Accuracy +10% (cap 40)
-- Attack +10% (cap 40)
-- Ranged Accuracy +10% (cap 40)
-- Ranged Attack +10% (cap 40)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6466)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 7)
    target:addMod(tpz.mod.FOOD_HP_CAP, 50)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.FOOD_ACCP, 10)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 40)
    target:addMod(tpz.mod.FOOD_RACCP, 10)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 40)
    target:addMod(tpz.mod.FOOD_ATTP, 10)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 40)
    target:addMod(tpz.mod.FOOD_RATTP, 10)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 40)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 7)
    target:delMod(tpz.mod.FOOD_HP_CAP, 50)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.FOOD_ACCP, 10)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 40)
    target:delMod(tpz.mod.FOOD_RACCP, 10)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 40)
    target:delMod(tpz.mod.FOOD_ATTP, 10)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 40)
    target:delMod(tpz.mod.FOOD_RATTP, 10)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 40)
end
