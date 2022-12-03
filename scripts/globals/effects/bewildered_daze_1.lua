-----------------------------------
-- xi.effect.BEWILDERED_DAZE_1
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

-- TODO: This should be crit evasion down, but is currently increasing
-- enemy crit rate (Is this the same thing?)
effectObject.onEffectGain = function(target, effect)
    local effectPower = effect:getPower()

    target:addMod(xi.mod.ENEMYCRITRATE, effectPower)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local effectPower = effect:getPower()

    target:delMod(xi.mod.ENEMYCRITRATE, effectPower)
end

return effectObject
