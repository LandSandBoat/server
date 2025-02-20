-----------------------------------
-- xi.effect.SUPER_BUFF
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    effect:addMod(xi.mod.ATTP, power)
    effect:addMod(xi.mod.DEFP, power)
    effect:addMod(xi.mod.MATT, power)
    effect:addMod(xi.mod.MEVA, power)
    -- The following only applies to Nidhogg.  If this buff is to be used anywhere else, a check on mob name (NOT ID) would be a good choice
    target:setAnimationSub(2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setAnimationSub(0)
end

return effectObject
