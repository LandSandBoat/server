-----------------------------------
--
-- tpz.effect.ACCURACY_DOWN
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ACC, -effect:getPower())
end

function onEffectTick(target, effect)
    -- the effect restore accuracy of 1 every 3 ticks.
    local downACC_effect_size = effect:getPower()
    if (downACC_effect_size > 0) then
        effect:setPower(downACC_effect_size - 1)
        target:delMod(tpz.mod.ACC, -1)
    end
end

function onEffectLose(target, effect)
    local downACC_effect_size = effect:getPower()
    if (downACC_effect_size > 0) then
        target:delMod(tpz.mod.ACC, -effect:getPower())
    end
end
