-----------------------------------
-- xi.effect.LEVEL_RESTRICTION
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:levelRestriction(effect:getPower())
    target:messageBasic(xi.msg.basic.LEVEL_IS_RESTRICTED, effect:getPower()) -- <target>'s level is restricted to <param>

    if target:getObjType() == xi.objType.PC then
        target:clearTrusts()
    end
end


effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:levelRestriction(0)
end

return effect_object
