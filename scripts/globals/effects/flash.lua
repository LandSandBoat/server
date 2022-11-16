-----------------------------------
-- xi.effect.FLASH
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    local flashEffect_size = effect:getPower()
    if flashEffect_size > 0 then
        effect:setPower(flashEffect_size - math.ceil(flashEffect_size / 2))
        target:delMod(xi.mod.ACC, -math.ceil(flashEffect_size / 2))
    end
end

effectObject.onEffectLose = function(target, effect)
    local flashEffect_size = effect:getPower()
    if flashEffect_size > 0 then
        target:delMod(xi.mod.ACC, -flashEffect_size)
    end
end

return effectObject
