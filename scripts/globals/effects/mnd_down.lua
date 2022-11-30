-----------------------------------
-- xi.effect.MND_DOWN
-----------------------------------
require("scripts/globals/status")
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
    local downMND_effect_size = effect:getPower()
    if downMND_effect_size > 0 then
        effect:setPower(downMND_effect_size - 1)
        target:delMod(xi.mod.MND, -1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downMND_effect_size = effect:getPower()
    if downMND_effect_size > 0 then
        target:delMod(xi.mod.MND, -downMND_effect_size)
    end
end

return effectObject
