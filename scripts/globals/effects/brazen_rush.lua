-----------------------------------
-- xi.effect.BRAZEN_RUSH
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.BRAZEN_RUSH_EFFECT)

    target:addMod(xi.mod.ATT, 4 * jpLevel)
    target:addMod(xi.mod.DOUBLE_ATTACK, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    local prevPower = effect:getPower()
    local nextPower = prevPower - 10

    target:delMod(xi.mod.DOUBLE_ATTACK, prevPower)
    effect:setPower(nextPower)
    target:addMod(xi.mod.DOUBLE_ATTACK, nextPower)
end

effectObject.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.BRAZEN_RUSH_EFFECT)

    target:delMod(xi.mod.ATT, 4 * jpLevel)
    target:delMod(xi.mod.DOUBLE_ATTACK, effect:getPower())
end

return effectObject
