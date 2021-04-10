-----------------------------------
-- xi.effect.BRAZEN_RUSH
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.BRAZEN_RUSH_EFFECT)

    target:addMod(xi.mod.ATTACK, 4 * jpLevel)
    target:addMod(xi.mod.DOUBLE_ATTACK, effect:getPower())
end

effect_object.onEffectTick = function(target,effect)
    local prevPower = effect:getPower()
    local nextPower = prevPower - 10

    target:delMod(xi.mod.DOUBLE_ATTACK, prevPower)
    effect:setPower(nextPower)
    target:addMod(xi.mod.DOUBLE_ATTACK, nextPower)
end

effect_object.onEffectLose = function(target,effect)
    local jpLevel = target:getJobPointLevel(xi.jp.BRAZEN_RUSH_EFFECT)

    target:delMod(xi.mod.ATTACK, 4 * jpLevel)
    target:delMod(xi.mod.DOUBLE_ATTACK, effect:getPower())
end

return effect_object
