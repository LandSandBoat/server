-----------------------------------
-- tpz.effect.MND_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    if ((target:getStat(tpz.mod.MND) - effect:getPower()) < 0) then
        effect:setPower(target:getStat(tpz.mod.MND))
    end
    target:addMod(tpz.mod.MND, -effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
    -- the effect restore mind of 1 every 3 ticks.
    local downMND_effect_size = effect:getPower()
    if (downMND_effect_size > 0) then
        effect:setPower(downMND_effect_size - 1)
        target:delMod(tpz.mod.MND, -1)
    end
end

effect_object.onEffectLose = function(target, effect)
    local downMND_effect_size = effect:getPower()
    if (downMND_effect_size > 0) then
        target:delMod(tpz.mod.MND, -downMND_effect_size)
    end
end

return effect_object
