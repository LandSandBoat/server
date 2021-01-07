-----------------------------------
-- tpz.effect.ICE_SPIKES
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SPIKES, 2)
    target:addMod(tpz.mod.SPIKES_DMG, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SPIKES, 2)
    target:delMod(tpz.mod.SPIKES_DMG, effect:getPower())
end

return effecttbl
