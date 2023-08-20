-----------------------------------
-- xi.effect.VIT_BOOST
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect loses vitality of 1 every 3 ticks depending on the source of the boost
    local boostVITEffectSize = effect:getPower()
    if boostVITEffectSize > 0 then
        effect:setPower(boostVITEffectSize - 1)
        target:delMod(xi.mod.VIT, 1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local boostVITEffectSize = effect:getPower()
    if boostVITEffectSize > 0 then
        target:delMod(xi.mod.VIT, boostVITEffectSize)
    end
end

return effectObject
