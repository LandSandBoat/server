-----------------------------------
-- xi.effect.INT_BOOST
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect loses intelligence of 1 every 3 ticks depending on the source of the boost
    local boostINT_effect_size = effect:getPower()
    if boostINT_effect_size > 0 then
        effect:setPower(boostINT_effect_size - 1)
        target:delMod(xi.mod.INT, 1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local boostINT_effect_size = effect:getPower()
    if boostINT_effect_size > 0 then
        target:delMod(xi.mod.INT, boostINT_effect_size)
    end
end

return effectObject
