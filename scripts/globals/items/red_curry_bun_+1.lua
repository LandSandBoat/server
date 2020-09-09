-----------------------------------------
-- ID: 5765
-- Item: red_curry_bun_+1
-- Food Effect: 60 Min, All Races
-----------------------------------------
-- TODO: Group effects
-- Health 35
-- Strength 7
-- Agility 3
-- Attack % 25 (cap 150)
-- Ranged Atk % 25 (cap 150)
-- Demon Killer 6
-- Resist Sleep +5
-- HP recovered when healing +6
-- MP recovered when healing +3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5765)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 35)
    target:addMod(tpz.mod.STR, 7)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.FOOD_ATTP, 25)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 150)
    target:addMod(tpz.mod.FOOD_RATTP, 25)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 150)
    target:addMod(tpz.mod.DEMON_KILLER, 6)
    target:addMod(tpz.mod.SLEEPRES, 5)
    target:addMod(tpz.mod.HPHEAL, 6)
    target:addMod(tpz.mod.MPHEAL, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 35)
    target:delMod(tpz.mod.STR, 7)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.FOOD_ATTP, 25)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 150)
    target:delMod(tpz.mod.FOOD_RATTP, 25)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 150)
    target:delMod(tpz.mod.DEMON_KILLER, 6)
    target:delMod(tpz.mod.SLEEPRES, 5)
    target:delMod(tpz.mod.HPHEAL, 6)
    target:delMod(tpz.mod.MPHEAL, 3)
end
