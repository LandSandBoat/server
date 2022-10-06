-----------------------------------
-- xi.effect.FAN_DANCE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Waltz recast effect is handled in the waltz scripts
    target:delStatusEffect(xi.effect.HASTE_SAMBA)
    target:delStatusEffect(xi.effect.ASPIR_SAMBA)
    target:delStatusEffect(xi.effect.DRAIN_SAMBA)
    target:delStatusEffect(xi.effect.SABER_DANCE)
    target:addMod(xi.mod.ENMITY, 15)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ENMITY, 15)
end

return effectObject
