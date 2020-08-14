-----------------------------------------
-- ID: 5964
-- Item: Felicifruit
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Agility -7
-- Intelligence 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5964)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, -7)
    target:addMod(tpz.mod.INT, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, -7)
    target:delMod(tpz.mod.INT, 5)
end
