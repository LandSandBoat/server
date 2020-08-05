-----------------------------------------
-- ID: 14925
-- Item: hydra_mittens
-- Item Effect: ACC +15 RACC +15
-- Duration: 3 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14925 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 180, 14925)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ACC, 15)
    target:addMod(tpz.mod.RACC, 15)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ACC, 15)
    target:delMod(tpz.mod.RACC, 15)
end
