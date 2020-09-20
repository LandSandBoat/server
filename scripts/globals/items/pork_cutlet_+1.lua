-----------------------------------------
-- ID: 6395
-- Item: pork_cutlet_+1
-- Food Effect: 240Min, All Races
-----------------------------------------
-- HP +45
-- STR +8
-- INT -8
-- Fire resistance +21
-- Attack +21% (cap 125)
-- Ranged Attack +21% (cap 125)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 6395)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 45)
    target:addMod(tpz.mod.STR, 8)
    target:addMod(tpz.mod.INT, -8)
    target:addMod(tpz.mod.FIRERES, 21)
    target:addMod(tpz.mod.FOOD_ATTP, 21)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 125)
    target:addMod(tpz.mod.FOOD_RATTP, 21)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 125)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 45)
    target:delMod(tpz.mod.STR, 8)
    target:delMod(tpz.mod.INT, -8)
    target:delMod(tpz.mod.FIRERES, 21)
    target:delMod(tpz.mod.FOOD_ATTP, 21)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 125)
    target:delMod(tpz.mod.FOOD_RATTP, 21)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 125)
end
