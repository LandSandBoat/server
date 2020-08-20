-----------------------------------------
-- ID: 5924
-- Item: Smoldering Salisbury Steak
-- Food Effect: 180 Min, All Races
-----------------------------------------
-- HP +30
-- Strength +7
-- Intelligence -5
-- Attack % 20 Cap 160
-- Ranged Attack %20 Cap 160
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5924)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.STR, 7)
    target:addMod(tpz.mod.INT, -5)
    target:addMod(tpz.mod.FOOD_ATTP, 20)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 160)
    target:addMod(tpz.mod.FOOD_RATTP, 20)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 160)
    target:addMod(tpz.mod.DRAGON_KILLER, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.STR, 7)
    target:delMod(tpz.mod.INT, -5)
    target:delMod(tpz.mod.FOOD_ATTP, 20)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 160)
    target:delMod(tpz.mod.FOOD_RATTP, 20)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 160)
    target:delMod(tpz.mod.DRAGON_KILLER, 5)
end
