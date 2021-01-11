-----------------------------------
-- tpz.effect.EVASION_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local power = math.min(effect:getPower(), target:getStat(tpz.mod.EVA))
    effect:setPower(power)
    target:delMod(tpz.mod.EVA, power)
end

-- only Feint uses tick, which restores 10 evasion per tick
effect_object.onEffectTick = function(target, effect)
    local power = effect:getPower()
    local adj = math.min(power, 10)
    effect:setPower(power - adj)
    target:addMod(tpz.mod.EVA, adj)
end

effect_object.onEffectLose = function(target, effect)
    local power = effect:getPower()
    target:addMod(tpz.mod.EVA, power)
end

return effect_object
