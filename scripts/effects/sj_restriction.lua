-----------------------------------
-- xi.effect.SJ_RESTRICTION
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if target:getObjType() == xi.objType.PC then
        target:messageBasic(xi.msg.basic.UNABLE_TO_ACCESS_SJ)
    end

    target:recalculateStats()
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:recalculateStats()
end

return effectObject
