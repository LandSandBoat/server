-----------------------------------------
-- ID: 5887
-- Item: montagna
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP +8% (cap 140)
-- Increases rate of combat skill gains by 60%
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5887)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 8)
    target:addMod(tpz.mod.FOOD_HP_CAP, 140)
    target:addMod(tpz.mod.COMBAT_SKILLUP_RATE, 60)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 8)
    target:delMod(tpz.mod.FOOD_HP_CAP, 140)
    target:delMod(tpz.mod.COMBAT_SKILLUP_RATE, 60)
end
