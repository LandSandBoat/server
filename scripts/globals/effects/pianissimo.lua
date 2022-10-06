-----------------------------------
-- xi.effect.PIANISSIMO
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.PIANISSIMO_EFFECT)

    target:addMod(xi.mod.SONG_SPELLCASTING_TIME, jpValue * 2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.PIANISSIMO_EFFECT)

    target:delMod(xi.mod.SONG_SPELLCASTING_TIME, jpValue * 2)
end

return effectObject
