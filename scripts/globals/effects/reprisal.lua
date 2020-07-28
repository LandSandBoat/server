-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SPIKES, 6)
     -- Spike damage is calculated on hit in battleutils::TakePhysicalDamage
    target:setMod(tpz.mod.SPIKES_DMG, 0)
    target:addMod(tpz.mod.SHIELDBLOCKRATE, 50)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SPIKES, 6)
    target:setMod(tpz.mod.SPIKES_DMG, 0)
    target:delMod(tpz.mod.SHIELDBLOCKRATE, 50)
end
