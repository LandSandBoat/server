-----------------------------------------
-- ID: 4456
-- Item: Boiled Crab
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Vitality 2
-- defense % 27
-- defense % 50
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4456)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.FOOD_DEFP, 27)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 50)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.FOOD_DEFP, 27)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 50)
end
