-----------------------------------
--
--      tpz.effect.ETUDE
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(effect:getSubPower(), effect:getPower())
end

function onEffectTick(target, effect)
    -- the effect loses modifier of 1 every 10 ticks.
    local song_effect_size = effect:getPower()
    if (effect:getTier() == 2 and effect:getPower() > 0) then
        effect:setPower(song_effect_size -1)
        target:delMod(effect:getSubPower(), 1)
    end
end

function onEffectLose(target, effect)
    target:delMod(effect:getSubPower(), effect:getPower())
end
