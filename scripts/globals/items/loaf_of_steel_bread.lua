-----------------------------------------
-- ID: 4573
-- Item: loaf_of_steel_bread
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health 6
-- Vitality 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4573)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 6)
    target:addMod(tpz.mod.VIT, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 6)
    target:delMod(tpz.mod.VIT, 1)
end
