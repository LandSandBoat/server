-----------------------------------
-- xi.effect.BIO
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    local subpower = effect:getSubPower()
    target:addMod(xi.mod.ATTP, -subpower)
    target:addMod(xi.mod.REGEN_DOWN, power)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    local subpower = effect:getSubPower()
    target:delMod(xi.mod.ATTP, -subpower)
    target:delMod(xi.mod.REGEN_DOWN, power)
end

return effectObject
