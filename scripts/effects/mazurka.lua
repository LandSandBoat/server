-----------------------------------
-- xi.effect.MAZURKA
-- Notes: Effect subType for enhancing songs stores IDs of the caster. Set in scripts/globals/spells/enhancing_song.lua
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MOVE_SPEED_MAZURKA, effect:getPower())
    effect:addMod(xi.mod.AGI, effect:getSubPower()) -- Apply Stat Buff from AUGMENT_SONG_STAT
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
