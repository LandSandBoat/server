-----------------------------------
-- xi.effect.ASTRAL_CONDUIT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.BP_DELAY, 99)
    target:addMod(xi.mod.MPP, 100)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.BP_DELAY, 99)
    target:delMod(xi.mod.MPP, 100)
end

return effect_object
