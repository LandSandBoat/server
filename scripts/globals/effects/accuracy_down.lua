-----------------------------------
-- xi.effect.ACCURACY_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, -effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
    -- the effect restore accuracy of 1 every 3 ticks.
    local downACC_effect_size = effect:getPower()
    if (downACC_effect_size > 0) then
        effect:setPower(downACC_effect_size - 1)
        target:delMod(xi.mod.ACC, -1)
    end
end

effect_object.onEffectLose = function(target, effect)
    local downACC_effect_size = effect:getPower()
    if (downACC_effect_size > 0) then
        target:delMod(xi.mod.ACC, -effect:getPower())
    end
end

return effect_object
