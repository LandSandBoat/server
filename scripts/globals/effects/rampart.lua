-----------------------------------
-- xi.effect.RAMPART
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEF, 23)
    target:addMod(xi.mod.RAMPART_MAGIC_SHIELD, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEF, 23)
    target:setMod(xi.mod.RAMPART_MAGIC_SHIELD, 0)
end

return effectObject
