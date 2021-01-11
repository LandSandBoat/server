-----------------------------------
-- tpz.effect.STONESKIN
-- Absorbs a certain amount of damage from physical and magical attacks.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:setMod(tpz.mod.STONESKIN, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setMod(tpz.mod.STONESKIN, 0)
end

return effect_object
