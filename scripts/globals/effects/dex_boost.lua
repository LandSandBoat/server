-----------------------------------
-- xi.effect.DEX_BOOST
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
    -- the effect loses dexterity of 1 every 3 ticks depending on the source of the boost
    local boostDEX_effect_size = effect:getPower()
    if (boostDEX_effect_size > 0) then
        effect:setPower(boostDEX_effect_size - 1)
        target:delMod(xi.mod.DEX, 1)
    end
end

effect_object.onEffectLose = function(target, effect)
    local boostDEX_effect_size = effect:getPower()
    if (boostDEX_effect_size > 0) then
        target:delMod(xi.mod.DEX, boostDEX_effect_size)
    end
end

return effect_object
