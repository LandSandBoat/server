-----------------------------------------
-- ID: 4353
-- Item: sea_bass_croute
-- Food Effect: 30Min, All Races
-----------------------------------------
-- MP +5% (cap 150)
-- Dexterity 4
-- Mind 5
-- Accuracy 3
-- Ranged Accuracy % 6 (cap 20)
-- HP recovered while healing 9
-- MP recovered while healing 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4353)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 5)
    target:addMod(tpz.mod.FOOD_MP_CAP, 150)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.ACC, 3)
    target:addMod(tpz.mod.FOOD_RACCP, 6)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 20)
    target:addMod(tpz.mod.HPHEAL, 9)
    target:addMod(tpz.mod.MPHEAL, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 5)
    target:delMod(tpz.mod.FOOD_MP_CAP, 150)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.ACC, 3)
    target:delMod(tpz.mod.FOOD_RACCP, 6)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 20)
    target:delMod(tpz.mod.HPHEAL, 9)
    target:delMod(tpz.mod.MPHEAL, 2)
end
