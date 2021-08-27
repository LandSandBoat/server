-----------------------------------
-- xi.effect..COUNTERSTANCE
-- DEF is removed in core as equip swaps can mess this up otherwise!
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.COUNTER, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.COUNTER, effect:getPower())
end

return effect_object
