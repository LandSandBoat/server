-----------------------------------
-- xi.effect.SOUL_VOICE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SOUL_VOICE_EFFECT)

    target:addMod(xi.mod.SONG_SPELLCASTING_TIME, 2 * jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SOUL_VOICE_EFFECT)

    target:delMod(xi.mod.SONG_SPELLCASTING_TIME, 2 * jpValue)
end

return effectObject
