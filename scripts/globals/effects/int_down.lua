-----------------------------------
--
--     tpz.effect.INT_DOWN
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    if ((target:getStat(tpz.mod.INT) - effect:getPower()) < 0) then
        effect:setPower(target:getStat(tpz.mod.INT))
    end
    target:addMod(tpz.mod.INT, -effect:getPower())
end

function onEffectTick(target, effect)
    -- the effect restore intelligence of 1 every 3 ticks.
    local downINT_effect_size = effect:getPower()
    if (downINT_effect_size > 0) then
        effect:setPower(downINT_effect_size - 1)
        target:delMod(tpz.mod.INT, -1)
    end
end

function onEffectLose(target, effect)
    local downINT_effect_size = effect:getPower()
    if (downINT_effect_size > 0) then
        target:delMod(tpz.mod.INT, -downINT_effect_size)
    end
end
