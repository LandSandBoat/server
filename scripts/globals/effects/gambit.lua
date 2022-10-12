-----------------------------------
-- xi.effect.GAMBIT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
-- intentionall blank, handled in scripts/globals/job_utils/rune_fencer
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
--intentionally blank, effects removed in CPP
end

return effectObject
