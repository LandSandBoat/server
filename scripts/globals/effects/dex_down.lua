-----------------------------------
-- xi.effect.DEX_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if (target:getStat(xi.mod.DEX) - effect:getPower()) < 0 then
        effect:setPower(target:getStat(xi.mod.DEX))
    end

    target:addMod(xi.mod.DEX, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect restore dexterity of 1 every 3 ticks.
    local downDEX_effect_size = effect:getPower()
    if downDEX_effect_size > 0 then
        effect:setPower(downDEX_effect_size - 1)
        target:delMod(xi.mod.DEX, -1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downDEX_effect_size = effect:getPower()
    if downDEX_effect_size > 0 then
        target:delMod(xi.mod.DEX, -downDEX_effect_size)
    end
end

return effectObject
