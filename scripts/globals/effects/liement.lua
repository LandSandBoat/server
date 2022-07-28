-----------------------------------
-- xi.effect.LIEMENT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

-- these functions are intentionally blank. See scripts/globals/job_utils/rune_fencer.lua
effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
end

return effect_object
