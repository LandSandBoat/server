-----------------------------------
-- xi.effect.PASTORAL
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, effect:getSubPower()) -- Apply Stat Buff from AUGMENT_SONG_STAT
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, effect:getSubPower()) -- Remove Stat Buff from AUGMENT_SONG_STAT
end

return effect_object
