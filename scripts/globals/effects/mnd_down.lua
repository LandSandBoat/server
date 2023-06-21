-----------------------------------
-- xi.effect.MND_DOWN
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if (target:getStat(xi.mod.MND) - effect:getPower()) < 0 then
        effect:setPower(target:getStat(xi.mod.MND))
    end

    target:addMod(xi.mod.MND, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect restore mind of 1 every 3 ticks.
    local downMNDEffectSize = effect:getPower()
    if downMNDEffectSize > 0 then
        effect:setPower(downMNDEffectSize - 1)
        target:delMod(xi.mod.MND, -1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downMNDEffectSize = effect:getPower()
    if downMNDEffectSize > 0 then
        target:delMod(xi.mod.MND, -downMNDEffectSize)
    end
end

return effectObject
