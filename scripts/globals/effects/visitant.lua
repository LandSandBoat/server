-----------------------------------
--
-- tpz.effect.VISITANT
--
-----------------------------------

function onEffectGain(target, effect)
end

function onEffectTick(target, effect)
    --[[
    local duration = effect:getDuration()
    if (target:getCharVar("Abyssea_Time") >= 3) then
        target:setCharVar("Abyssea_Time", duration)
    end
    Some messages about remaining time.will need to handled outside of this effect (zone ejection warnings after visitant is gone).
    ]]
end

function onEffectLose(target, effect)
end
