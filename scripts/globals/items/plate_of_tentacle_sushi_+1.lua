-----------------------------------------
-- ID: 5216
-- Item: plate_of_tentacle_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- HP 20
-- Dexterity 3
-- Agility 3
-- Accuracy % 20 (cap 20)
-- Ranged Accuracy % 20 (cap 20)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5216)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.FOOD_ACCP, 20)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 20)
    target:addMod(tpz.mod.FOOD_RACCP, 20)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 20)
    target:addMod(tpz.mod.DOUBLE_ATTACK, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.FOOD_ACCP, 20)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 20)
    target:delMod(tpz.mod.FOOD_RACCP, 20)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 20)
    target:delMod(tpz.mod.DOUBLE_ATTACK, 1)
end
