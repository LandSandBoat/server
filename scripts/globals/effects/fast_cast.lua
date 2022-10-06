-----------------------------------
--
-- xi.effect.FAST_CAST -- used by Inspiration Merits in Vallation/Valiance
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INSPIRATION_FAST_CAST, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INSPIRATION_FAST_CAST, effect:getPower())
end

return effectObject
