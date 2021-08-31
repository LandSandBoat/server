-----------------------------------
-- xi.effect.PROWESS
-- Increased treasure casket discovery.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
-- This might not be % in retail...If not a % just change ATTP to just ATT
    target:addMod(xi.mod.ATTP, effect:getPower())
    target:addMod(xi.mod.RATTP, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATTP, effect:getPower())
    target:delMod(xi.mod.RATTP, effect:getPower())
end

return effect_object
