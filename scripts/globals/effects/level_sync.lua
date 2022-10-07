-----------------------------------
-- xi.effect.LEVEL_SYNC
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:levelRestriction(effect:getPower())

    if target:getObjType() == xi.objType.PC then
        target:clearTrusts()
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:levelRestriction(0)
    target:disableLevelSync()
end

return effectObject
