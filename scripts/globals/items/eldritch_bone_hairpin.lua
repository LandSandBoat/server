-----------------------------------------
-- ID: 15268
-- Item: eldritch_bone_hairpin
-- Item Effect: INT+2 MND+2
-- Duration: 30 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15268 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 1800, 15268)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.MND, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.MND, 2)
end
