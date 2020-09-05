-----------------------------------------
-- ID: 4294
-- Item: serving_of_medicinal_quus
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Dexterity 1
-- Mind -1
-- Ranged ACC % 7
-- Ranged ACC Cap 15
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4294)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.FOOD_RACCP, 7)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 15)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.FOOD_RACCP, 7)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 15)
end
