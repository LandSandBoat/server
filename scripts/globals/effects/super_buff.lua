-----------------------------------
-- xi.effect.SUPER_BUFF
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    target:addMod(xi.mod.ATTP, power)
    target:addMod(xi.mod.DEFP, power)
    target:addMod(xi.mod.MATT, power)
    target:addMod(xi.mod.MEVA, power)
    -- The following only applies to Nidhogg.  If this buff is to be used anywhere else, a check on mob name (NOT ID) would be a good choice
    target:setAnimationSub(2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    target:delMod(xi.mod.ATTP, power)
    target:delMod(xi.mod.DEFP, power)
    target:delMod(xi.mod.MATT, power)
    target:delMod(xi.mod.MEVA, power)
    target:setAnimationSub(0)
end

return effectObject
