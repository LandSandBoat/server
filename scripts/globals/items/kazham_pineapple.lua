-----------------------------------------
-- ID: 4432
-- Item: kazham_pineapple
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Agility -5
-- Intelligence 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4432)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, -5)
    target:addMod(tpz.mod.INT, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, -5)
    target:delMod(tpz.mod.INT, 3)
end
