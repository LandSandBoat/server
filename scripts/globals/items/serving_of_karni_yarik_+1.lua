-----------------------------------------
-- ID: 5589
-- Item: serving_of_karni_yarik_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Agility 4
-- Vitality -2
-- Attack % 22 (cap 70)
-- Ranged Attack % 22 (cap 70)
-- Evasion +7
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5589)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.VIT, -2)
    target:addMod(tpz.mod.FOOD_ATTP, 22)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 70)
    target:addMod(tpz.mod.FOOD_RATTP, 22)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 70)
    target:addMod(tpz.mod.EVA, 7)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.VIT, -2)
    target:delMod(tpz.mod.FOOD_ATTP, 22)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 70)
    target:delMod(tpz.mod.FOOD_RATTP, 22)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 70)
    target:delMod(tpz.mod.EVA, 7)
end
