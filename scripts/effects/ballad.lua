-----------------------------------
-- xi.effect.BALLAD
-- getPower returns the TIER (e.g. 1, 2, 3, 4)
-- DO NOT ALTER ANY OF THE EFFECT VALUES! DO NOT ALTER EFFECT POWER!
-- TODO: Find a better way of doing this. Need to account for varying modifiers + CASTER's skill (not target)
-- Notes: Effect subType for enhancing songs stores IDs of the caster. Set in scripts/globals/spells/enhancing_song.lua
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REFRESH, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REFRESH, effect:getPower())
end

return effectObject
