-----------------------------------------
-- ID: 4499
-- Item: loaf_of_iron_bread
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4499)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 4)
    target:addMod(tpz.mod.VIT, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 4)
    target:delMod(tpz.mod.VIT, 1)
end
