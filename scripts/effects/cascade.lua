-----------------------------------
-- xi.effect.CASCADE
-----------------------------------
---@type TEffect
local effectObject = {}

-- Cascade is a carrier buff: its power holds the Magic Damage bonus and its subPower holds the TP
-- to spend, both captured when the ability is used. The bonus is added to, and the buff (with its
-- TP cost) is consumed by, the next elemental damage spell. See
-- scripts/globals/job_utils/black_mage.lua and scripts/globals/spells/damage_spell.lua.
effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
