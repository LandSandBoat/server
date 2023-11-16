-----------------------------------
-- xi.effect.OVERLOAD
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local pet = target:getPet()
    if pet then
        pet:setLocalVar('overload', 1)
        pet:addMod(xi.mod.HASTE_MAGIC, -5000)
        pet:addMod(xi.mod.MOVE_SPEED_WEIGHT_PENALTY, 50)
        pet:addMod(xi.mod.EVA, -10)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local pet = target:getPet()
    if pet and pet:getLocalVar('overload') ~= 0 then
        pet:setLocalVar('overload', 0)
        pet:delMod(xi.mod.HASTE_MAGIC, -5000)
        pet:delMod(xi.mod.MOVE_SPEED_WEIGHT_PENALTY, 50)
        pet:delMod(xi.mod.EVA, -10)
    end
end

return effectObject
