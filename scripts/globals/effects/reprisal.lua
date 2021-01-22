-----------------------------------
-- tpz.effect.REPRISAL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.SPIKES, 6)
     -- Spike damage is calculated on hit in battleutils::TakePhysicalDamage
    target:setMod(tpz.mod.SPIKES_DMG, 0)
    target:addMod(tpz.mod.SHIELDBLOCKRATE, 50)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.SPIKES, 6)
    target:setMod(tpz.mod.SPIKES_DMG, 0)
    target:delMod(tpz.mod.SHIELDBLOCKRATE, 50)
end

return effect_object
