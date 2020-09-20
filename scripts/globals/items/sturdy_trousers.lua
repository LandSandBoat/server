-----------------------------------------
-- ID: 15610
-- Item: sturdy_trousers
-- Item Effect: HP +10
-- Duration: 30 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15610 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 1800, 15610)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 10)
end
