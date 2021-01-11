----------------------------------------
-- tpz.effect.INVISIBLE
----------------------------------------
require("scripts/globals/msg")
----------------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
    local tick = effect:getLastTick()
    if (tick < 4 and tick ~= 0) then
        target:messageBasic(tpz.msg.basic.ABOUT_TO_WEAR_OFF, effect:getType())
    end
end

effect_object.onEffectLose = function(target, effect)
end

return effect_object
