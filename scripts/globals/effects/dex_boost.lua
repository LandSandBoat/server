-----------------------------------
--
-- tpz.effect.DEX_BOOST
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, effect:getPower())
end

function onEffectTick(target, effect)
    -- the effect loses dexterity of 1 every 3 ticks depending on the source of the boost
    local boostDEX_effect_size = effect:getPower()
    if (boostDEX_effect_size > 0) then
        effect:setPower(boostDEX_effect_size - 1)
        target:delMod(tpz.mod.DEX, 1)
    end
end

function onEffectLose(target, effect)
    boostDEX_effect_size = effect:getPower()
    if (boostDEX_effect_size > 0) then
        target:delMod(tpz.mod.DEX, boostDEX_effect_size)
    end
end
