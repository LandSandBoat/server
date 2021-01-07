-----------------------------------
-- tpz.effect.MIGHTY_STRIKES
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
target:addMod(tpz.mod.CRITHITRATE, 100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:addMod(tpz.mod.CRITHITRATE, -100)
end

return effecttbl
