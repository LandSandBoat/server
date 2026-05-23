-----------------------------------
-- Moogle's REFRESH Aura
-- Refresh: 3 MP/tick at lv. 99
-- Magical skill gain rate: static +20%, same as the magic skillup food (Stuffed Pitaru)
-- Stacks with player Indi/Geo version
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local lvl = effect:getPower()

    effect:addMod(xi.mod.REFRESH, xi.trust.auraValue(lvl, 3))
    effect:addMod(xi.mod.MAGIC_SKILLUP_RATE, 20)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
