-----------------------------------
-- Star Sibyl's Magic Attack Aura
-- Magic Attack Boost: max +19 at level 99
-- Magic Accuracy boost: max +19 at level 99
-- Stacks with player Indi/Geo version
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local lvl = effect:getPower()
    local modVal = xi.trust.auraValue(lvl, 6)

    effect:addMod(xi.mod.MATT, modVal)
    effect:addMod(xi.mod.MACC, modVal)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
