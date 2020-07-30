-----------------------------------------
-- ID: 14787
-- Item: Deadeye Earring
-- Item Effect: Ranged Attack 20
-- Duration: 3 Minutes
-----------------------------------------
require("scripts/globals/status")

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14787 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 180, 14787)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.RATT, 20)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.RATT, 20)
end
