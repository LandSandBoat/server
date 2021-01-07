-----------------------------------
-- tpz.effect.ANCIENT_CIRCLE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
   target:addMod(tpz.mod.DRAGON_KILLER, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
   target:delMod(tpz.mod.DRAGON_KILLER, effect:getPower())
end

return effecttbl
