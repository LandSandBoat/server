-----------------------------------
-- xi.effect.DEX_BOOST
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect loses dexterity of 1 every 3 ticks depending on the source of the boost
    local boostDEXEffectSize = effect:getPower()
    if boostDEXEffectSize > 0 then
        effect:setPower(boostDEXEffectSize - 1)
        target:delMod(xi.mod.DEX, 1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local boostDEXEffectSize = effect:getPower()
    if boostDEXEffectSize > 0 then
        target:delMod(xi.mod.DEX, boostDEXEffectSize)
    end
end

return effectObject
