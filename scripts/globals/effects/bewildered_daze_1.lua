-----------------------------------
-- xi.effect.BEWILDERED_DAZE_1
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

-- TODO: CRIT_HIT_EVASION_DOWN is currently not part of hit calculations,
-- and needs to be implemented (but does exist in the enum)
effectObject.onEffectGain = function(target, effect)
    local effectPower = effect:getPower()

    target:addMod(xi.mod.CRIT_HIT_EVASION_DOWN, effectPower * -1)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local effectPower = effect:getPower()

    target:delMod(xi.mod.CRIT_HIT_EVASION_DOWN, effectPower * -1)
end

return effectObject
