-----------------------------------------
-- ID: 14516
-- Item: hydra_harness
-- Item Effect: Attack +25, Ranged Attack +25
-- Duration: 3 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14516 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 180, 14516)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ATT, 25)
    target:addMod(tpz.mod.RATT, 25)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ATT, 25)
    target:delMod(tpz.mod.RATT, 25)
end
