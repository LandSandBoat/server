-----------------------------------
--
-- xi.effect.FAST_CAST -- used by Inspiration Merits in Vallation/Valiance
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INSPIRATION_FAST_CAST, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INSPIRATION_FAST_CAST, effect:getPower())
end

return effect_object
