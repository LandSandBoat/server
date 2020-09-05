-----------------------------------------
-- ID: 4345
-- Item: serving_of_flounder_meuniere_+1
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Dexterity 6
-- Vitality 1
-- Mind -1
-- Ranged ACC 15
-- Ranged ATT % 14
-- Ranged ATT Cap 30
-- Enmity -4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4345)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 6)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.RACC, 15)
    target:addMod(tpz.mod.FOOD_RATTP, 14)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 30)
    target:addMod(tpz.mod.ENMITY, -4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 6)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.RACC, 15)
    target:delMod(tpz.mod.FOOD_RATTP, 14)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 30)
    target:delMod(tpz.mod.ENMITY, -4)
end
