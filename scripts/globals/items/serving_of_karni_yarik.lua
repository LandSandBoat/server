-----------------------------------------
-- ID: 5588
-- Item: serving_of_karni_yarik
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Agility 3
-- Vitality -1
-- Attack % 20 (cap 65)
-- Ranged Attack % 20 (cap 65)
-- Evasion +6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5588)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.FOOD_ATTP, 20)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 65)
    target:addMod(tpz.mod.FOOD_RATTP, 20)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 65)
    target:addMod(tpz.mod.EVA, 6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.FOOD_ATTP, 20)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 65)
    target:delMod(tpz.mod.FOOD_RATTP, 20)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 65)
    target:delMod(tpz.mod.EVA, 6)
end
