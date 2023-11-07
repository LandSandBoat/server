-----------------------------------
-- xi.effect.MAGIC_ATK_DOWN
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getPower() > 100 then
        effect:setPower(50)
    end

    target:addMod(xi.mod.MATT, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MACC, -effect:getPower())
end

return effectObject
