-----------------------------------
--
-- tpz.effect.VIT_BOOST
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIT, effect:getPower())
end

function onEffectTick(target, effect)
    -- the effect loses vitality of 1 every 3 ticks depending on the source of the boost
    local boostVIT_effect_size = effect:getPower()
    if (boostVIT_effect_size > 0) then
        effect:setPower(boostVIT_effect_size - 1)
        target:delMod(tpz.mod.VIT, 1)
    end
end

function onEffectLose(target, effect)
    local boostVIT_effect_size = effect:getPower()
    if (boostVIT_effect_size > 0) then
        target:delMod(tpz.mod.VIT, boostVIT_effect_size)
    end
end
