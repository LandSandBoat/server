-----------------------------------
-- xi.effect.CHR_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if (target:getStat(xi.mod.CHR) - effect:getPower()) < 0 then
        effect:setPower(target:getStat(xi.mod.CHR))
    end

    target:addMod(xi.mod.CHR, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect restore charism of 1 every 3 ticks.
    local downCHREffectSize = effect:getPower()
    if downCHREffectSize > 0 then
        effect:setPower(downCHREffectSize - 1)
        target:delMod(xi.mod.CHR, -1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downCHREffectSize = effect:getPower()
    if downCHREffectSize > 0 then
        target:delMod(xi.mod.CHR, -downCHREffectSize)
    end
end

return effectObject
