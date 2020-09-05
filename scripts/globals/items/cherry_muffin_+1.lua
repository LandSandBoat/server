-----------------------------------------
-- ID: 5654
-- Item: Cherry Muffin
-- Food Effect: 1Hr, All Races
-----------------------------------------
-- Intelligence 2
-- MP % 10 (cap 85)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5654)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.FOOD_MPP, 10)
    target:addMod(tpz.mod.FOOD_MP_CAP, 85)
    target:addMod(tpz.mod.AGI, -1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.FOOD_MPP, 10)
    target:delMod(tpz.mod.FOOD_MP_CAP, 85)
    target:delMod(tpz.mod.AGI, -1)
end
