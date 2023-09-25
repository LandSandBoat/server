-----------------------------------
-- xi.effect.REPRISAL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SPIKES, 6)
    -- Spike damage is calculated on hit in battleutils::TakePhysicalDamage
    target:setMod(xi.mod.SPIKES_DMG, 0)
    target:addMod(xi.mod.SHIELDBLOCKRATE, 50)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SPIKES, 6)
    target:setMod(xi.mod.SPIKES_DMG, 0)
    target:delMod(xi.mod.SHIELDBLOCKRATE, 50)
end

return effectObject
