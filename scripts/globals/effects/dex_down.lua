-----------------------------------
-- xi.effect.DEX_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    if ((target:getStat(xi.mod.DEX) - effect:getPower()) < 0) then
        effect:setPower(target:getStat(xi.mod.DEX))
    end
    target:addMod(xi.mod.DEX, -effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
    -- the effect restore dexterity of 1 every 3 ticks.
    local downDEX_effect_size = effect:getPower()
    if (downDEX_effect_size > 0) then
        effect:setPower(downDEX_effect_size - 1)
        target:delMod(xi.mod.DEX, -1)
    end
end

effect_object.onEffectLose = function(target, effect)
    local downDEX_effect_size = effect:getPower()
    if (downDEX_effect_size > 0) then
        target:delMod(xi.mod.DEX, -downDEX_effect_size)
    end
end

return effect_object
