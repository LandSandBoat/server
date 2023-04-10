-----------------------------------
-- xi.effect.RERAISE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    --power level is the raise number (1, 2, 3)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    if target:getHP() <= 0 then
        target:sendReraise(effect:getPower())
    end
end

return effectObject
