-----------------------------------
-- xi.effect.EVASION_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = math.min(effect:getPower(), target:getStat(xi.mod.EVA))
    effect:setPower(power)
    target:delMod(xi.mod.EVA, power)
end

-- only Feint uses tick, which restores 10 evasion per tick
effectObject.onEffectTick = function(target, effect)
    local power = effect:getPower()
    local adj = math.min(power, 10)
    effect:setPower(power - adj)
    target:addMod(xi.mod.EVA, adj)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    target:addMod(xi.mod.EVA, power)
end

return effectObject
