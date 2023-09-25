-----------------------------------
-- xi.effect.INT_BOOST
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect loses intelligence of 1 every 3 ticks depending on the source of the boost
    local boostINTEffectSize = effect:getPower()
    if boostINTEffectSize > 0 then
        effect:setPower(boostINTEffectSize - 1)
        target:delMod(xi.mod.INT, 1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local boostINTEffectSize = effect:getPower()
    if boostINTEffectSize > 0 then
        target:delMod(xi.mod.INT, boostINTEffectSize)
    end
end

return effectObject
