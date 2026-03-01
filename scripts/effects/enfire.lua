-----------------------------------
-- xi.effect.ENFIRE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ENSPELL, xi.element.FIRE)
    effect:addMod(xi.mod.ENSPELL_DMG, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
