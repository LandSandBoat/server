-----------------------------------
--
--     tpz.effect.VIT_DOWN
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    if ((target:getStat(tpz.mod.VIT) - effect:getPower()) < 0) then
        effect:setPower(target:getStat(tpz.mod.VIT))
    end
    target:addMod(tpz.mod.VIT, -effect:getPower())
end

function onEffectTick(target, effect)
    -- the effect restore vitality of 1 every 3 ticks.
    local downVIT_effect_size = effect:getPower()
    if (downVIT_effect_size > 0) then
        effect:setPower(downVIT_effect_size - 1)
        target:delMod(tpz.mod.VIT, -1)
    end
end

function onEffectLose(target, effect)
    local downVIT_effect_size = effect:getPower()
    if (downVIT_effect_size > 0) then
        target:delMod(tpz.mod.VIT, -downVIT_effect_size)
    end
end
