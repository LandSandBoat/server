-----------------------------------------
-- ID: 6212
-- Item: slice of marinara pizza +1
-- Food Effect: 60 minutes, all Races
-----------------------------------------
-- HP +25
-- Accuracy+11% (Max. 58)
-- Attack+21% (Max. 55)
-- "Undead Killer"+5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6212)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 25)
    target:addMod(tpz.mod.FOOD_ACCP, 11)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 58)
    target:addMod(tpz.mod.FOOD_ATTP, 21)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 55)
    target:addMod(tpz.mod.UNDEAD_KILLER, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 25)
    target:delMod(tpz.mod.FOOD_ACCP, 11)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 58)
    target:delMod(tpz.mod.FOOD_ATTP, 21)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 55)
    target:delMod(tpz.mod.UNDEAD_KILLER, 5)
end
