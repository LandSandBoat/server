-----------------------------------
-- tpz.effect.RERAISE
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    --power level is the raise number (1, 2, 3)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    if (target:getHP() <= 0) then
        target:sendReraise(effect:getPower())
    end
end

return effect_object
