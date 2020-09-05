-----------------------------------------
-- ID: 5925
-- Item: Charred Salisbury Steak
-- Food Effect: 240 Min, All Races
-----------------------------------------
-- HP +32
-- Strength +8
-- Intelligence -6
-- Attack % 22 Cap 165
-- Ranged Attack %22 Cap 165
-- Dragon Killer +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5925)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 32)
    target:addMod(tpz.mod.STR, 8)
    target:addMod(tpz.mod.INT, -6)
    target:addMod(tpz.mod.FOOD_ATTP, 22)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 165)
    target:addMod(tpz.mod.FOOD_RATTP, 22)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 165)
    target:addMod(tpz.mod.DRAGON_KILLER, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 32)
    target:delMod(tpz.mod.STR, 8)
    target:delMod(tpz.mod.INT, -6)
    target:delMod(tpz.mod.FOOD_ATTP, 22)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 165)
    target:delMod(tpz.mod.FOOD_RATTP, 22)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 165)
    target:delMod(tpz.mod.DRAGON_KILLER, 5)
end
