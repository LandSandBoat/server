-----------------------------------------
-- ID: 5194
-- Item: Bowl of Pomodoro Sauce
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Intelligence 2
-- Mind 2
-- HP Recovered while healing +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5194)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.MND, 2)
    target:addMod(tpz.mod.HPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.MND, 2)
    target:delMod(tpz.mod.HPHEAL, 1)
end
