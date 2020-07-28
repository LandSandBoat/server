-----------------------------------
--
-- tpz.effect.AGI_BOOST
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, effect:getPower())
end

function onEffectTick(target, effect)
    -- the effect loses agility of 1 every 3 ticks depending on the source of the agi boost
    local boostAGI_effect_size = effect:getPower()
    if (boostAGI_effect_size > 0) then
        effect:setPower(boostAGI_effect_size - 1)
        target:delMod(tpz.mod.AGI, 1)
    end
end

function onEffectLose(target, effect)
    local boostAGI_effect_size = effect:getPower()
    if (boostAGI_effect_size > 0) then
        target:delMod(tpz.mod.AGI, boostAGI_effect_size)
    end
end
