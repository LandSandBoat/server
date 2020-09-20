-----------------------------------
--
--     tpz.effect.SNEAK
--
-----------------------------------
require("scripts/globals/msg")

function onEffectGain(target, effect)
end

function onEffectTick(target, effect)
    local tick = effect:getLastTick()
    if (tick < 4 and tick ~= 0) then
        target:messageBasic(tpz.msg.basic.ABOUT_TO_WEAR_OFF, effect:getType())
    end
end

function onEffectLose(target, effect)
end
