-----------------------------------
-- tpz.effect.PRELUDE
-- getPower returns the TIER (e.g. 1, 2, 3, 4)
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.RACC, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.RACC, effect:getPower())
end

return effect_object
