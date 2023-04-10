-----------------------------------
-- xi.effect.INTERVENE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local prevATT = target:getStat(xi.mod.ATT)
    local prevACC = target:getACC()

    effect:setPower(prevATT)
    effect:setSubPower(prevACC)

    target:delMod(xi.mod.ATT, prevATT)
    target:delMod(xi.mod.ACC, prevACC)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local prevATT = effect:getPower()
    local prevACC = effect:getSubPower()

    target:addMod(xi.mod.ATT, prevATT)
    target:addMod(xi.mod.ACC, prevACC)
end

return effectObject
