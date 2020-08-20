-----------------------------------------
-- ID: 4550
-- Item: plate_of_bream_risotto
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Health 40
-- Dexterity 6
-- Agility 3
-- Mind -4
-- Health Regen While Healing 1
-- Ranged Accuracy % 6
-- Ranged Accuracy Cap 15
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4550)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 40)
    target:addMod(tpz.mod.DEX, 6)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.MND, -4)
    target:addMod(tpz.mod.HPHEAL, 1)
    target:addMod(tpz.mod.FOOD_RACCP, 6)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 15)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 40)
    target:delMod(tpz.mod.DEX, 6)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.MND, -4)
    target:delMod(tpz.mod.HPHEAL, 1)
    target:delMod(tpz.mod.FOOD_RACCP, 6)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 15)
end
