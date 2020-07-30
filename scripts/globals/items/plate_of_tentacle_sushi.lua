-----------------------------------------
-- ID: 5215
-- Item: plate_of_tentacle_sushi
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP 20
-- Dexterity 3
-- Agility 3
-- Mind -1
-- Accuracy % 20 (cap 18)
-- Ranged Accuracy % 20 (cap 18)
-- Double Attack 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5215)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.FOOD_ACCP, 20)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 18)
    target:addMod(tpz.mod.FOOD_RACCP, 20)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 18)
    target:addMod(tpz.mod.DOUBLE_ATTACK, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.FOOD_ACCP, 20)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 18)
    target:delMod(tpz.mod.FOOD_RACCP, 20)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 18)
    target:delMod(tpz.mod.DOUBLE_ATTACK, 1)
end
