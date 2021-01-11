-----------------------------------
-- tpz.effect.ASSASSINS_CHARGE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.QUAD_ATTACK, effect:getPower())
    target:addMod(tpz.mod.TRIPLE_ATTACK, 100)
    if (effect:getSubPower() > 0) then
        target:addMod(tpz.mod.CRITHITRATE, effect:getSubPower())
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.QUAD_ATTACK, effect:getPower())
    target:delMod(tpz.mod.TRIPLE_ATTACK, 100)
    if (effect:getSubPower() > 0) then -- tpz.mod.AUGMENTS_ASSASSINS_CHARGE
        target:delMod(tpz.mod.CRITHITRATE, effect:getSubPower())
    end
end

return effect_object
