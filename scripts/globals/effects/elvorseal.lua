-----------------------------------
-- xi.effect.ELVORSEAL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)

end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    if (target:getHP() <= 0) then
        target:sendReraise(effect:getPower())
    end
end

return effectObject
