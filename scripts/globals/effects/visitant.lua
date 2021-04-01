-----------------------------------
-- xi.effect.VISITANT
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
    --[[
    local duration = effect:getDuration()
    if (target:getCharVar("Abyssea_Time") >= 3) then
        target:setCharVar("Abyssea_Time", duration)
    end
    Some messages about remaining time.will need to handled outside of this effect (zone ejection warnings after visitant is gone).
    ]]
end

effect_object.onEffectLose = function(target, effect)
end

return effect_object
