-----------------------------------
-- xi.effect.STR_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if (target:getStat(xi.mod.STR) - effect:getPower()) < 0 then
        effect:setPower(target:getStat(xi.mod.STR))
    end

    target:addMod(xi.mod.STR, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect restore strengh of 1 every 3 ticks.
    local downSTREffectSize = effect:getPower()
    if downSTREffectSize > 0 then
        effect:setPower(downSTREffectSize - 1)
        target:delMod(xi.mod.STR, -1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downSTREffectSize = effect:getPower()
    if downSTREffectSize > 0 then
        target:delMod(xi.mod.STR, -downSTREffectSize)
    end
end

return effectObject
