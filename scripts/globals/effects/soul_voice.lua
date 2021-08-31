-----------------------------------
-- xi.effect.SOUL_VOICE
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SOUL_VOICE_EFFECT)

    target:addMod(xi.mod.SONG_SPELLCASTING_TIME, 2 * jpValue)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SOUL_VOICE_EFFECT)

    target:delMod(xi.mod.SONG_SPELLCASTING_TIME, 2 * jpValue)
end

return effect_object
