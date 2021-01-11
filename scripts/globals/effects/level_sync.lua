-----------------------------------
-- tpz.effect.LEVEL_SYNC
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:levelRestriction(effect:getPower())

    if target:getObjType() == tpz.objType.PC then
        target:clearTrusts()
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:levelRestriction(0)
    target:disableLevelSync()
end

return effect_object
