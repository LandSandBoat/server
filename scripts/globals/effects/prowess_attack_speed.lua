-----------------------------------
-- tpz.effect.PROWESS
-- Increased attack speed
-- Note: Doesn't alter TP gain like -delay would, and
-- doesn't alter JA timers like other sources of haste.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HASTE_ABILITY, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HASTE_ABILITY, effect:getPower())
end

return effect_object
