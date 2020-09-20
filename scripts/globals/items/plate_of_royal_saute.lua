-----------------------------------------
-- ID: 4295
-- Item: plate_of_royal_sautee
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Strength 5
-- Agility 1
-- Intelligence -2
-- Attack +22% (cap 80)
-- Ranged Attack +22% (cap 80)
-- Stun Resist +4
-- HP recovered while healing +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4295)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 5)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.INT, -2)
    target:addMod(tpz.mod.FOOD_ATTP, 22)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 80)
    target:addMod(tpz.mod.FOOD_RATTP, 22)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 80)
    target:addMod(tpz.mod.STUNRES, 4)
    target:addMod(tpz.mod.HPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 5)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.INT, -2)
    target:delMod(tpz.mod.FOOD_ATTP, 22)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 80)
    target:delMod(tpz.mod.FOOD_RATTP, 22)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 80)
    target:delMod(tpz.mod.STUNRES, 4)
    target:delMod(tpz.mod.HPHEAL, 1)
end
