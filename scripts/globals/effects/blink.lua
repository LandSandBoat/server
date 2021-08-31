-----------------------------------
-- xi.effect.BLINK
-- No need for addMod since blinks never stack.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:setMod(xi.mod.BLINK, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setMod(xi.mod.BLINK, 0)
end

return effect_object
