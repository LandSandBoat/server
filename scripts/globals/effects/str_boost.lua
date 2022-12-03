-----------------------------------
-- xi.effect.STR_BOOST
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect loses strengh of 1 every 3 ticks depending on the source of the boost
    local boostSTREffectSize = effect:getPower()
    if boostSTREffectSize > 0 then
        effect:setPower(boostSTREffectSize - 1)
        target:delMod(xi.mod.STR, 1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local boostSTREffectSize = effect:getPower()
    if boostSTREffectSize > 0 then
        target:delMod(xi.mod.STR, boostSTREffectSize)
    end
end

return effectObject
