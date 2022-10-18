-----------------------------------
-- xi.effect.PROWESS
-- Increased treasure casket discovery.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
-- This might not be % in retail. If not a % just change ATTP to just ATT
    target:addMod(xi.mod.ATTP, effect:getPower())
    target:addMod(xi.mod.RATTP, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATTP, effect:getPower())
    target:delMod(xi.mod.RATTP, effect:getPower())
end

return effectObject
