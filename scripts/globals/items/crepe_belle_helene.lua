-----------------------------------------
-- ID: 5778
-- Item: Crepe Belle Helene
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- Intelligence +2
-- MP Healing +3
-- Magic Accuracy +21% (cap 50)
-- Magic Defense +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5778)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.MPHEAL, 3)
    target:addMod(tpz.mod.FOOD_MACCP, 21)
    target:addMod(tpz.mod.FOOD_MACC_CAP, 50)
    target:addMod(tpz.mod.MDEF, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.MPHEAL, 3)
    target:delMod(tpz.mod.FOOD_MACCP, 21)
    target:delMod(tpz.mod.FOOD_MACC_CAP, 50)
    target:delMod(tpz.mod.MDEF, 1)
end
