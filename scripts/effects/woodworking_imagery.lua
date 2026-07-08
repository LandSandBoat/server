-----------------------------------
-- xi.effect.WOODWORKING_IMAGERY
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.WOOD, effect:getPower())
    effect:addMod(xi.mod.SYNTH_MATERIAL_LOSS_WOODWORKING, effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
