-----------------------------------
-- xi.effect.INVINCIBLE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.UDMGPHYS, -10000)
    target:addMod(xi.mod.UDMGRANGE, -10000)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.UDMGPHYS, -10000)
    target:delMod(xi.mod.UDMGRANGE, -10000)
end

return effectObject
