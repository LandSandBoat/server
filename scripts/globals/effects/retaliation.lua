-----------------------------------
-- tpz.effect.RETALIATION
-- Allows you to counterattack but reduces movement speed.
-- Unlike counter, grants TP like a regular melee attack.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MOVE, -8)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MOVE, -8)
end

return effect_object
