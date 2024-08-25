-----------------------------------
-- xi.effect.SEIGAN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- TODO: confirm if this def bonus is only active with 2hander equipped and either follow the pattern currently in hasso/desperate blows or consider a latent sytle effect
    local jpValue = target:getJobPointLevel(xi.jp.SEIGAN_EFFECT)

    target:addMod(xi.mod.DEF, jpValue * 3)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SEIGAN_EFFECT)

    target:delMod(xi.mod.DEF, jpValue * 3)
end

return effectObject
