-----------------------------------------
-- ID: 5167
-- Item: coeurl_sub_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Magic 15
-- Strength 5
-- Agility 1
-- Intelligence -2
-- Health Regen While Healing 1
-- Attack % 22
-- Attack Cap 80
-- Ranged ATT % 22
-- Ranged ATT Cap 80
-- Sleep Resist 1
-- Stun Resist 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5167)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 15)
    target:addMod(tpz.mod.STR, 5)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.INT, -2)
    target:addMod(tpz.mod.HPHEAL, 1)
    target:addMod(tpz.mod.FOOD_ATTP, 22)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 80)
    target:addMod(tpz.mod.FOOD_RATTP, 22)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 80)
    target:addMod(tpz.mod.SLEEPRES, 1)
    target:addMod(tpz.mod.STUNRES, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 15)
    target:delMod(tpz.mod.STR, 5)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.INT, -2)
    target:delMod(tpz.mod.HPHEAL, 1)
    target:delMod(tpz.mod.FOOD_ATTP, 22)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 80)
    target:delMod(tpz.mod.FOOD_RATTP, 22)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 80)
    target:delMod(tpz.mod.SLEEPRES, 1)
    target:delMod(tpz.mod.STUNRES, 4)
end
