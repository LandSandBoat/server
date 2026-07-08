-----------------------------------
-- xi.effect.MEIKYO_SHISUI
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.MEIKYO_SHISUI_EFFECT)

    effect:addMod(xi.mod.SKILLCHAINDMG, 200 * jpValue) -- Base 10000 mod
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
