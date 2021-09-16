-----------------------------------
-- xi.effect.HYMNUS
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CHR, effect:getSubPower()) -- Apply Stat Buff from AUGMENT_SONG_STAT
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    if (target:getHP() <= 0) then
        target:sendReraise(effect:getPower())
    end
    target:delMod(xi.mod.CHR, effect:getSubPower()) -- Remove Stat Buff from AUGMENT_SONG_STAT
end

return effect_object
