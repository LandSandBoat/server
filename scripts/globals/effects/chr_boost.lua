-----------------------------------
-- xi.effect.CHR_BOOST
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CHR, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect loses Charism of 1 every 3 ticks depending on the source of the boost
    local boostCHR_effect_size = effect:getPower()
    if (boostCHR_effect_size > 0) then
        effect:setPower(boostCHR_effect_size - 1)
        target:delMod(xi.mod.CHR, 1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local boostCHR_effect_size = effect:getPower()
    if (boostCHR_effect_size > 0) then
        target:delMod(xi.mod.CHR, boostCHR_effect_size)
    end
end

return effectObject
