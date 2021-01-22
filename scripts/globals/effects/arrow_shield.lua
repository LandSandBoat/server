-----------------------------------
-- tpz.effect.ARROW_SHIELD
-- Blocks all ranged attacks
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.UDMGRANGE, -100)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.UDMGRANGE, -100)
end

return effect_object
