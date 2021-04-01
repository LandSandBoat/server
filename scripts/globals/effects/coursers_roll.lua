-----------------------------------
-- xi.effect.COURSERS_ROLL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    -- target:addMod(xi.mod.SNAPSHOT, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    -- target:delMod(xi.mod.SNAPSHOT, effect:getPower())
end

return effect_object
