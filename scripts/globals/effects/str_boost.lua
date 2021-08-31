-----------------------------------
-- xi.effect.STR_BOOST
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
    -- the effect loses strengh of 1 every 3 ticks depending on the source of the boost
    local boostSTR_effect_size = effect:getPower()
    if (boostSTR_effect_size > 0) then
        effect:setPower(boostSTR_effect_size - 1)
        target:delMod(xi.mod.STR, 1)
    end
end

effect_object.onEffectLose = function(target, effect)
    local boostSTR_effect_size = effect:getPower()
    if (boostSTR_effect_size > 0) then
        target:delMod(xi.mod.STR, boostSTR_effect_size)
    end
end

return effect_object
