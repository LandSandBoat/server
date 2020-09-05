-----------------------------------------
-- ID: 18240
-- Item: Spirit Lantern
-- Item Effect: Magic Damage +10%
-- Duration: 3 Minutes
-----------------------------------------
require("scripts/globals/status")

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 18240 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 180, 18240)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MAGIC_DAMAGE, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MAGIC_DAMAGE, 10)
end
