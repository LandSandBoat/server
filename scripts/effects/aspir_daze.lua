-----------------------------------
-- xi.effect.ASPIR_DAZE
-- Notes:
-- Debuff applied to an entity when hit by an another entity's party that have a corresponding Samba effect active.
-- sourceTypeParam for Daze effects stores the ID of the attacker. See battleutils.cpp "HandleEnspell"
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
