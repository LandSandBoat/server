-----------------------------------
-- Brygid's CHR Aura
-- CHR Boost: static +5 at 99
-- Defense Bonus: static +10% at 99
-- Magic Defense Bonus: +5% at 99
-- Stacks with player Indi/Geo version
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local lvl = effect:getPower()
    local modVal = xi.trust.auraValue(lvl, 5)

    effect:addMod(xi.mod.DEFP, xi.trust.auraValue(lvl, 9.7))
    effect:addMod(xi.mod.CHR, modVal)
    effect:addMod(xi.mod.MDEF, modVal)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
