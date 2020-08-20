-----------------------------------------
-- ID: 4555
-- Item: windurst_salad
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Magic 20
-- Agility 5
-- Vitality -1
-- Ranged ACC % 8
-- Ranged ACC Cap 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4555)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 20)
    target:addMod(tpz.mod.AGI, 5)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.FOOD_RACCP, 8)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 20)
    target:delMod(tpz.mod.AGI, 5)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.FOOD_RACCP, 8)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 10)
end
