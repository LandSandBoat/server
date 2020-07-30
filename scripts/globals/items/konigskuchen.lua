-----------------------------------------
-- ID: 5614
-- Item: konigskuchen
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Health 8
-- Magic % 3
-- Magic Cap 13
-- Intelligence 2
-- hMP +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5614)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 8)
    target:addMod(tpz.mod.FOOD_MPP, 3)
    target:addMod(tpz.mod.FOOD_MP_CAP, 13)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 8)
    target:delMod(tpz.mod.FOOD_MPP, 3)
    target:delMod(tpz.mod.FOOD_MP_CAP, 13)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.MPHEAL, 1)
end
