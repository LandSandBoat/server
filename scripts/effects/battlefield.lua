-----------------------------------
-- xi.effect.BATTLEFIELD
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if target:getPet() then
        target:getPet():addStatusEffect(effect)
    end

    if target:getObjType() == xi.objType.PC then
        target:clearTrusts()
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local pet = target:getPet()
    if pet then
        pet:delStatusEffect(xi.effect.BATTLEFIELD)
        pet:leaveBattlefield(1)
    end

    target:setLocalVar("[battlefield]area", 0)
end

return effectObject
