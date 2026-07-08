-----------------------------------
-- Sakura's REGEN Aura
-- Regen: 6 MP/tick at lv. 99
-- Physical skill gain rate: static +20%, same as the physical skillup food (Saltena)
-- Stacks with player Indi/Geo version
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local lvl = effect:getPower()

    effect:addMod(xi.mod.REGEN, xi.trust.auraValue(lvl, 6))
    effect:addMod(xi.mod.COMBAT_SKILLUP_RATE, 20)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
