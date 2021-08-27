-----------------------------------
-- xi.effect.HASTE_SAMBA_HASTE
-- JA Haste 5-10%
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HASTE_ABILITY, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HASTE_ABILITY, effect:getPower())
end

return effect_object
