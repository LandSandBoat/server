-----------------------------------
-- xi.effect.PROWESS
-- Enhanced magic acc. and magic atk
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MATT, effect:getPower())
    target:addMod(xi.mod.MACC, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MATT, effect:getPower())
    target:delMod(xi.mod.MACC, effect:getPower())
end

return effect_object
