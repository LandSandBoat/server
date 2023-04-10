-----------------------------------
-- xi.effect.AGI_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if (target:getStat(xi.mod.AGI) - effect:getPower()) < 0 then
        effect:setPower(target:getStat(xi.mod.AGI))
    end

    target:addMod(xi.mod.AGI, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect restore agility of 1 every 3 ticks.
    local downAGIEffectSize = effect:getPower()
    if downAGIEffectSize > 0 then
        effect:setPower(downAGIEffectSize - 1)
        target:delMod(xi.mod.AGI, -1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downAGIEffectSize = effect:getPower()
    if downAGIEffectSize > 0 then
        target:delMod(xi.mod.AGI, -downAGIEffectSize)
    end
end

return effectObject
