-----------------------------------------
-- ID: 6217
-- Item: slice of anchovy_pizza
-- Food Effect: 30 minutes, all Races
-----------------------------------------
-- HP +30
-- DEX +1
-- Accuracy +9% (Cap 15)
-- Attack +10% (Cap 20)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6217)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.FOOD_ACCP, 9)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 15)
    target:addMod(tpz.mod.FOOD_ATTP, 10)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 20)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.FOOD_ACCP, 9)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 15)
    target:delMod(tpz.mod.FOOD_ATTP, 10)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 20)
end
