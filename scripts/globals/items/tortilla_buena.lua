-----------------------------------------
-- ID: 5181
-- Item: tortilla_buena
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health 8
-- Vitality 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5181)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 8)
    target:addMod(tpz.mod.VIT, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 8)
    target:delMod(tpz.mod.VIT, 4)
end
