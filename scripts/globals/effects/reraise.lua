-----------------------------------
--
-- tpz.effect.RERAISE
--
-----------------------------------

function onEffectGain(target, effect)
    --power level is the raise number (1, 2, 3)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if (target:getHP() <= 0) then
        target:sendReraise(effect:getPower())
    end
end
