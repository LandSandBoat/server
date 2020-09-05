-----------------------------------------
-- ID: 5609
-- Item: hellsteak
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Health 20
-- Strength 6
-- Intelligence -2
-- Health Regen While Healing 2
-- hMP +1
-- Attack % 18 (cap 145)
-- Ranged ATT % 18 (cap 145)
-- Dragon Killer 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5609)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.INT, -2)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 1)
    target:addMod(tpz.mod.FOOD_ATTP, 18)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 145)
    target:addMod(tpz.mod.FOOD_RATTP, 18)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 145)
    target:addMod(tpz.mod.DRAGON_KILLER, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.INT, -2)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 1)
    target:delMod(tpz.mod.FOOD_ATTP, 18)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 145)
    target:delMod(tpz.mod.FOOD_RATTP, 18)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 145)
    target:delMod(tpz.mod.DRAGON_KILLER, 5)
end
