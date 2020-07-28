-----------------------------------------
-- ID: 15559
-- Item: vision_ring
-- Item Effect: ACC+2 RACC+2
-- Duration: 30 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15559 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 1800, 15559)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ACC, 2)
    target:addMod(tpz.mod.RACC, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ACC, 2)
    target:delMod(tpz.mod.RACC, 2)
end
