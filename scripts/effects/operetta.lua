-----------------------------------
-- xi.effect.OPERETTA
-- Notes: Effect subType for enhancing songs stores IDs of the caster. Set in scripts/globals/spells/enhancing_song.lua
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SILENCERES, effect:getPower())
    target:addMod(xi.mod.INT, effect:getSubPower()) -- Apply Stat Buff from AUGMENT_SONG_STAT
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SILENCERES, effect:getPower())
    target:delMod(xi.mod.INT, effect:getSubPower()) -- Remove Stat Buff from AUGMENT_SONG_STAT
end

return effectObject
