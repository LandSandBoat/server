-----------------------------------
-- xi.effect.VIT_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if (target:getStat(xi.mod.VIT) - effect:getPower()) < 0 then
        effect:setPower(target:getStat(xi.mod.VIT))
    end

    target:addMod(xi.mod.VIT, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect restore vitality of 1 every 3 ticks.
    local downVIT_effect_size = effect:getPower()
    if downVIT_effect_size > 0 then
        effect:setPower(downVIT_effect_size - 1)
        target:delMod(xi.mod.VIT, -1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downVIT_effect_size = effect:getPower()
    if downVIT_effect_size > 0 then
        target:delMod(xi.mod.VIT, -downVIT_effect_size)
    end
end

return effectObject
