-----------------------------------
-- Kuyin Hathdenna's Accuracy Aura
-- DEX Boost: +4 at level 99 with no title or Kuyin employed
-- Accuracy Boost: +24 at level 99 with no title or Kuyin employed
-- Ranged accuracy Boost: +24 at level 99 with no title or Kuyin employed
-- Boost values: +1 Bonus when Kuyin is employed in your Mog Garden, +1 Bonus when the player has the title "Kit Empathizer", rank may be involved
-- Stacks with player Indi/Geo version
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local lvl = effect:getPower()
    local modVal = xi.trust.auraValue(lvl, 24)

    effect:addMod(xi.mod.DEX, xi.trust.auraValue(lvl, 4))
    effect:addMod(xi.mod.ACC, modVal)
    effect:addMod(xi.mod.RACC, modVal)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
