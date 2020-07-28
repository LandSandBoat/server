-----------------------------------------
-- ID: 4292
-- Item: loaf_of_pain_de_neige
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health 18
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4292)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 18)
    target:addMod(tpz.mod.VIT, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 18)
    target:delMod(tpz.mod.VIT, 4)
end
