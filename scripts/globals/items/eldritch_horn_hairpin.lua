-----------------------------------------
-- ID: 15269
-- Item: eldritch_horn_hairpin
-- Item Effect: INT+3 MND+3
-- Duration: 30 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15269 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 1800, 15269)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, 3)
    target:addMod(tpz.mod.MND, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, 3)
    target:delMod(tpz.mod.MND, 3)
end
