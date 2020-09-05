-----------------------------------------
-- ID: 5697
-- Item: pepperoni_pizza
-- Food Effect: 3 hours, all Races
-----------------------------------------
-- HP +30
-- Strength 1
-- Accuracy 9% (caps @ 10)
-- Attack 10% (caps @ 15)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5697)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.STR, 1)
    target:addMod(tpz.mod.FOOD_ATTP, 10)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 15)
    target:addMod(tpz.mod.FOOD_ACCP, 9)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.STR, 1)
    target:delMod(tpz.mod.FOOD_ATTP, 10)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 15)
    target:delMod(tpz.mod.FOOD_ACCP, 9)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 10)
end
