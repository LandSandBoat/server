-----------------------------------
-- xi.effect.MADRIGAL
-- getPower returns the TIER (e.g. 1, 2, 3, 4)
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, effect:getPower())
    target:addMod(xi.mod.DEX, effect:getSubPower()) -- Apply Stat Buff from AUGMENT_SONG_STAT
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, effect:getPower())
    target:delMod(xi.mod.DEX, effect:getSubPower()) -- Remove Stat Buff from AUGMENT_SONG_STAT
end

return effect_object
