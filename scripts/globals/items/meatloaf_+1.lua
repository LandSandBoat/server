-----------------------------------------
-- ID: 5690
-- Item: Meatloaf +1
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- Strength 6
-- Agility 2
-- Intelligence -3
-- Attack 18% Cap 95
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5690)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.AGI, 2)
    target:addMod(tpz.mod.INT, -3)
    target:addMod(tpz.mod.FOOD_ATTP, 18)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 95)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.AGI, 2)
    target:delMod(tpz.mod.INT, -3)
    target:delMod(tpz.mod.FOOD_ATTP, 18)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 95)
end
