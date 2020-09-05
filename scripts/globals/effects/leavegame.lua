-----------------------------------
--
--     tpz.effect.LEAVEGAME
--
-----------------------------------

function onEffectGain(target, effect)
    target:setAnimation(33)
    target:messageSystem(effect:getPower(), 30)
end

function onEffectTick(target, effect)
    if (effect:getTickCount() > 5) then
        target:leavegame()
    else
        target:messageSystem(effect:getPower(), 30-effect:getTickCount()*5)
    end
end

function onEffectLose(target, effect)
    target:setAnimation(0)
end
