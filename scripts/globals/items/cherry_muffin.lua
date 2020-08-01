-----------------------------------------
-- ID: 5653
-- Item: Cherry Muffin
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Intelligence 1
-- Magic % 10
-- Magic Cap 80
-- Agility -1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5653)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.FOOD_MPP, 10)
    target:addMod(tpz.mod.FOOD_MP_CAP, 80)
    target:addMod(tpz.mod.AGI, -1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.FOOD_MPP, 10)
    target:delMod(tpz.mod.FOOD_MP_CAP, 80)
    target:delMod(tpz.mod.AGI, -1)
end
