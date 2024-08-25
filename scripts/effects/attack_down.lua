-----------------------------------
-- xi.effect.ATTACK_DOWN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getPower() > 100 then
        effect:setPower(50)
    end

    target:addMod(xi.mod.ATTP, -effect:getPower())
    target:addMod(xi.mod.RATTP, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATTP, -effect:getPower())
    target:delMod(xi.mod.RATTP, -effect:getPower())
end

return effectObject
