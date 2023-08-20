-----------------------------------
-- xi.effect.ICE_MANEUVER
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local pet = target:getPet()
    if pet then
        pet:addMod(xi.mod.INT, effect:getPower())
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local pet = target:getPet()
    if pet then
        pet:delMod(xi.mod.INT, effect:getPower())
    end
end

return effectObject
