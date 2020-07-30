-----------------------------------
--
-- tpz.effect.STR_BOOST
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, effect:getPower())
end

function onEffectTick(target, effect)
    -- the effect loses strengh of 1 every 3 ticks depending on the source of the boost
    local boostSTR_effect_size = effect:getPower()
    if (boostSTR_effect_size > 0) then
        effect:setPower(boostSTR_effect_size - 1)
        target:delMod(tpz.mod.STR, 1)
    end
end

function onEffectLose(target, effect)
    local boostSTR_effect_size = effect:getPower()
    if (boostSTR_effect_size > 0) then
        target:delMod(tpz.mod.STR, boostSTR_effect_size)
    end
end
