-----------------------------------
-- xi.effect.MOBILIZATION
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:messageBasic(xi.msg.basic.ABOUT_TO_WEAR_OFF, effect:getType())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:messageBasic(xi.msg.basic.STATUS_WEARS_OFF, effect:getType())
end

return effect_object
