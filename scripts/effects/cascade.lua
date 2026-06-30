-----------------------------------
-- xi.effect.CASCADE
-----------------------------------
---@type TEffect
local effectObject = {}

-- The Magic Damage bonus is stored in the effect's power when Cascade is used, and is applied to
-- (and consumed by) the next elemental damage spell via xi.job_utils.black_mage.tryConsumeCascade.
-- See scripts/globals/spells/damage_spell.lua.
effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
