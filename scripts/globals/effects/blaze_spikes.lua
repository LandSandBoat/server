-----------------------------------
--
-- tpz.effect.BLAZE_SPIKES
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SPIKES, 1)
    target:addMod(tpz.mod.SPIKES_DMG, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SPIKES, 1)
    target:delMod(tpz.mod.SPIKES_DMG, effect:getPower())
end
