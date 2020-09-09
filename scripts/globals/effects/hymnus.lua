-----------------------------------
-- Hymnus (reraise)
--
--
-----------------------------------

function onEffectGain(target, effect)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if (target:getHP() <= 0) then
        target:sendReraise(effect:getPower())
    end
end
