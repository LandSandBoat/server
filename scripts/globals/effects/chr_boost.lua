-----------------------------------
-- xi.effect.CHR_BOOST
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CHR, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect loses Charism of 1 every 3 ticks depending on the source of the boost
    local boostCHREffectSize = effect:getPower()
    if boostCHREffectSize > 0 then
        effect:setPower(boostCHREffectSize - 1)
        target:delMod(xi.mod.CHR, 1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local boostCHREffectSize = effect:getPower()
    if boostCHREffectSize > 0 then
        target:delMod(xi.mod.CHR, boostCHREffectSize)
    end
end

return effectObject
