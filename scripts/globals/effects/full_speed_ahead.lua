-----------------------------------
-- tpz.effect.FULL_SPEED_AHEAD
-- Helper for quest: Full Speed Ahead!
-----------------------------------
require("scripts/quests/full_speed_ahead")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    tpz.fsa.onEffectGain(target, effect)
end

effect_object.onEffectTick = function(target, effect)
    tpz.fsa.tick(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    tpz.fsa.onEffectLose(target, effect)
end

return effect_object
