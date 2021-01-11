-----------------------------------
-- tpz.effect.CHR_BOOST
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.CHR, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
    -- the effect loses Charism of 1 every 3 ticks depending on the source of the boost
    local boostCHR_effect_size = effect:getPower()
    if (boostCHR_effect_size > 0) then
        effect:setPower(boostCHR_effect_size - 1)
        target:delMod(tpz.mod.CHR, 1)
    end
end

effect_object.onEffectLose = function(target, effect)
    local boostCHR_effect_size = effect:getPower()
    if (boostCHR_effect_size > 0) then
        target:delMod(tpz.mod.CHR, boostCHR_effect_size)
    end
end

return effect_object
