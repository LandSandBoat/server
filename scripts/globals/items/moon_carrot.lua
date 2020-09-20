-----------------------------------------
-- ID: 4567
-- Item: moon_carrot
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Agility 1
-- Vitality -1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4567)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.VIT, -1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.VIT, -1)
end
