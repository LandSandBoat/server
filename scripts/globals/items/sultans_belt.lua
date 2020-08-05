-----------------------------------------
-- ID: 15867
-- Item: sultans_belt
-- Item Effect: STR +10
-- Duration: 60 seconds
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15867 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 60, 15867)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 10)
end
