-----------------------------------
-- tpz.effect.LEVEL_RESTRICTION
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:levelRestriction(effect:getPower())
    target:messageBasic(314, effect:getPower()) -- <target>'s level is restricted to <param>

    if target:getObjType() == tpz.objType.PC then
        target:clearTrusts()
    end
end


effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:levelRestriction(0)
end

return effect_object
