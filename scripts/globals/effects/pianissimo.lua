-----------------------------------
-- xi.effect.PIANISSIMO
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.PIANISSIMO_EFFECT)

    target:addMod(xi.mod.SONG_SPELLCASTING_TIME, jpValue * 2)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.PIANISSIMO_EFFECT)

    target:delMod(xi.mod.SONG_SPELLCASTING_TIME, jpValue * 2)
end

return effect_object
