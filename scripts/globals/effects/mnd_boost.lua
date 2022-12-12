-----------------------------------
-- xi.effect.MND_BOOST
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MND, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect loses mind of 1 every 3 ticks depending on the source of the boost
    local boostMNDEffectSize = effect:getPower()
    if boostMNDEffectSize > 0 then
        effect:setPower(boostMNDEffectSize - 1)
        target:delMod(xi.mod.MND, 1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local boostMNDEffectSize = effect:getPower()
    if boostMNDEffectSize > 0 then
        target:delMod(xi.mod.MND, boostMNDEffectSize)
    end
end

return effectObject
