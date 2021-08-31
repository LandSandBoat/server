-----------------------------------
-- xi.effect.COPY_IMAGE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:setMod(xi.mod.UTSUSEMI, effect:getSubPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setMod(xi.mod.UTSUSEMI, 0)
end

return effect_object
