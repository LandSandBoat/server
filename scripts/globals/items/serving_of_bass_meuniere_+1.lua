-----------------------------------------
-- ID: 4346
-- Item: serving_of_bass_meuniere_+1
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Health % 3 (cap 130)
-- Dexterity 3
-- Agility 3
-- Mind -3
-- Ranged ACC % 6
-- Ranged ACC Cap 20
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4346)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 3)
    target:addMod(tpz.mod.FOOD_HP_CAP, 130)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.MND, -3)
    target:addMod(tpz.mod.FOOD_RACCP, 6)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 20)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 3)
    target:delMod(tpz.mod.FOOD_HP_CAP, 130)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.MND, -3)
    target:delMod(tpz.mod.FOOD_RACCP, 6)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 20)
end
