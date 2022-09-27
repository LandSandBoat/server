-----------------------------------
-- xi.effect.INTERVENE
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local prevATT = target:getStat(xi.mod.ATT)
    local prevACC = target:getACC()

    effect:setPower(prevATT)
    effect:setSubPower(prevACC)

    target:delMod(xi.mod.ATT, prevATT)
    target:delMod(xi.mod.ACC, prevACC)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local prevATT = effect:getPower()
    local prevACC = effect:getSubPower()

    target:addMod(xi.mod.ATT, prevATT)
    target:addMod(xi.mod.ACC, prevACC)
end

return effect_object
