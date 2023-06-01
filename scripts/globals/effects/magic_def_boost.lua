-----------------------------------
-- xi.effect.MAGIC_DEF_BOOST
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getPower() > 100 then
        effect:setPower(50)
    end

    target:addMod(xi.mod.MDEF, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- decay the effect by 1 every effectTick
    local power = effect:getPower()
    if power > 0 then
        effect:setPower(power - 1)
        target:delMod(xi.mod.MDEF, 1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    if power > 0 then
        target:delMod(xi.mod.MDEF, power)
    end
end

return effectObject
