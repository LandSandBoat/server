-----------------------------------
-- xi.effect.INT_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    if ((target:getStat(xi.mod.INT) - effect:getPower()) < 0) then
        effect:setPower(target:getStat(xi.mod.INT))
    end
    target:addMod(xi.mod.INT, -effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
    -- the effect restore intelligence of 1 every 3 ticks.
    local downINT_effect_size = effect:getPower()
    if (downINT_effect_size > 0) then
        effect:setPower(downINT_effect_size - 1)
        target:delMod(xi.mod.INT, -1)
    end
end

effect_object.onEffectLose = function(target, effect)
    local downINT_effect_size = effect:getPower()
    if (downINT_effect_size > 0) then
        target:delMod(xi.mod.INT, -downINT_effect_size)
    end
end

return effect_object
