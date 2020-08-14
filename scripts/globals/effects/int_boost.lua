-----------------------------------
--
-- tpz.effect.INT_BOOST
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, effect:getPower())
end

function onEffectTick(target, effect)
    -- the effect loses intelligence of 1 every 3 ticks depending on the source of the boost
    local boostINT_effect_size = effect:getPower()
    if (boostINT_effect_size > 0) then
        effect:setPower(boostINT_effect_size - 1)
        target:delMod(tpz.mod.INT, 1)
    end
end

function onEffectLose(target, effect)
    local boostINT_effect_size = effect:getPower()
    if (boostINT_effect_size > 0) then
        target:delMod(tpz.mod.INT, boostINT_effect_size)
    end
end
