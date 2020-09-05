-----------------------------------
--
-- tpz.effect.AGI_DOWN
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    if ((target:getStat(tpz.mod.AGI) - effect:getPower()) < 0) then
        effect:setPower(target:getStat(tpz.mod.AGI))
    end
    target:addMod(tpz.mod.AGI, -effect:getPower())
end

function onEffectTick(target, effect)
    -- the effect restore agility of 1 every 3 ticks.
    local downAGI_effect_size = effect:getPower()
    if (downAGI_effect_size > 0) then
        effect:setPower(downAGI_effect_size - 1)
        target:delMod(tpz.mod.AGI, -1)
    end
end

function onEffectLose(target, effect)
    local downAGI_effect_size = effect:getPower()
    if (downAGI_effect_size > 0) then
        target:delMod(tpz.mod.AGI, -downAGI_effect_size)
    end
end
