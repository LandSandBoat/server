-----------------------------------
-- xi.effect.ASSASSINS_CHARGE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.QUAD_ATTACK, effect:getPower())
    target:addMod(xi.mod.TRIPLE_ATTACK, 100)
    if (effect:getSubPower() > 0) then
        target:addMod(xi.mod.CRITHITRATE, effect:getSubPower())
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.QUAD_ATTACK, effect:getPower())
    target:delMod(xi.mod.TRIPLE_ATTACK, 100)
    if (effect:getSubPower() > 0) then -- xi.mod.AUGMENTS_ASSASSINS_CHARGE
        target:delMod(xi.mod.CRITHITRATE, effect:getSubPower())
    end
end

return effect_object
