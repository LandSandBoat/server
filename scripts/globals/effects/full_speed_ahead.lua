-----------------------------------
-- xi.effect.FULL_SPEED_AHEAD
-- Helper for quest: Full Speed Ahead!
-----------------------------------
require("scripts/quests/full_speed_ahead")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    xi.fsa.onEffectGain(target, effect)
end

effectObject.onEffectTick = function(target, effect)
    xi.fsa.tick(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    xi.fsa.onEffectLose(target, effect)
end

return effectObject
