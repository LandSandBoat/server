-----------------------------------------
-- ID: 4271
-- Item: rice_dumpling
-- Food Effect: 30minutes, All Races
-----------------------------------------
-- HP 17
-- Strength 3
-- Vitality 2
-- Agility 1
-- Attack 20% (caps @ 45)
-- Ranged Attack 30% (caps @ 45)
-- HP Regeneration While Healing 2
-- MP Regeneration While Healing 2
-- Accuracy 5
-- Resist Paralyze +4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4271)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 17)
    target:addMod(tpz.mod.STR, 3)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.FOOD_ATTP, 20)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 45)
    target:addMod(tpz.mod.FOOD_RATTP, 30)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 45)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 2)
    target:addMod(tpz.mod.ACC, 5)
    target:addMod(tpz.mod.PARALYZERES, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 17)
    target:delMod(tpz.mod.STR, 3)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.FOOD_ATTP, 20)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 45)
    target:delMod(tpz.mod.FOOD_RATTP, 30)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 45)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 2)
    target:delMod(tpz.mod.ACC, 5)
    target:delMod(tpz.mod.PARALYZERES, 4)
end
