-----------------------------------
-- xi.effect.ENLIGHT
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.ENLIGHT_EFFECT)

    effect:addMod(xi.mod.ENSPELL, xi.element.LIGHT)
    effect:addMod(xi.mod.ENSPELL_DMG, effect:getPower() + jpValue)
    effect:addMod(xi.mod.ACC, jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
