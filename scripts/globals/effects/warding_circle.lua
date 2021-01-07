-----------------------------------
-- tpz.effect.WARDING_CIRCLE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
   target:addMod(tpz.mod.DEMON_KILLER, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
   target:delMod(tpz.mod.DEMON_KILLER, effect:getPower())
end

return effecttbl
