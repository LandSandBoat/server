-----------------------------------
-- xi.effect.OVERLOAD
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if target:getObjType() == xi.objType.PET then
        effect:addMod(xi.mod.HASTE_MAGIC, -5000)
        effect:addMod(xi.mod.MOVE_SPEED_WEIGHT_PENALTY, 50)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
