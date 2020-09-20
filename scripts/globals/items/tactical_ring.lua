-----------------------------------------
-- ID: 14679
-- Item: Tactical Ring
-- Item Effect: Regain 20
-- Duration: 2 Minutes
-----------------------------------------
require("scripts/globals/status")

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14679 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 120, 14679)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.REGAIN, 20)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.REGAIN, 20)
end
