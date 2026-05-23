-----------------------------------
-- Cornelia's HASTE Aura
-- Haste: +20% static value
-- Accuracy Boost: max 30 at 99
-- Ranged Accuracy Boost: max 30 at 99
-- Magic Accuracy Boost: max 30 at 99
-- stacks with player Indi/Geo version
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local lvl = effect:getPower()
    local modVal = xi.trust.auraValue(lvl, 30)

    effect:addMod(xi.mod.HASTE_MAGIC, 2000) -- This is a static 20%
    effect:addMod(xi.mod.ACC, modVal)
    effect:addMod(xi.mod.RACC, modVal)
    effect:addMod(xi.mod.MACC, modVal)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
