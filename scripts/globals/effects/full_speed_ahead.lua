-----------------------------------
--
-- tpz.effect.FULL_SPEED_AHEAD
-- Helper for quest: Full Speed Ahead!
--
-----------------------------------
require("scripts/quests/full_speed_ahead")
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target,effect)
    tpz.fsa.onEffectGain(target, effect)
end

function onEffectTick(target,effect)
    tpz.fsa.tick(target, effect)
end

function onEffectLose(target,effect)
    tpz.fsa.onEffectLose(target, effect)
end
