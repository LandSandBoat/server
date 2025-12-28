-----------------------------------
-- xi.effect.DRAIN_DAZE
-- Notes:
-- Debuff applied to an entity when hit by an another entity's party that have a corresponding Samba effect active.
-- sourceTypeParam for Daze effects stores the ID of the attacker. See battleutils.cpp "HandleEnspell"
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ENSPELL_DMG, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setMod(xi.mod.ENSPELL_DMG, 0)
end

return effectObject
