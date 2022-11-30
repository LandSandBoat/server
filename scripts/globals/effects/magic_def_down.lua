-----------------------------------
-- xi.effect.MAGIC_DEF_DOWN
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if (effect:getPower()>100) then
        effect:setPower(50)
    end
    target:delMod(xi.mod.MDEF, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:addMod(xi.mod.MDEF, effect:getPower())
end

return effectObject
