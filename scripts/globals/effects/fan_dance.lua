-----------------------------------
-- xi.effect.FAN_DANCE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    -- Waltz recast effect is handled in the waltz scripts
    target:delStatusEffect(xi.effect.HASTE_SAMBA)
    target:delStatusEffect(xi.effect.ASPIR_SAMBA)
    target:delStatusEffect(xi.effect.DRAIN_SAMBA)
    target:delStatusEffect(xi.effect.SABER_DANCE)
    target:addMod(xi.mod.ENMITY, 15)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ENMITY, 15)
end

return effect_object
