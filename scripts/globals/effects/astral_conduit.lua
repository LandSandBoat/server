-----------------------------------
-- tpz.effect.ASTRAL_CONDUIT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.BP_DELAY, 99)
    target:addMod(tpz.mod.MPP, 100)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.BP_DELAY, 99)
    target:delMod(tpz.mod.MPP, 100)
end

return effect_object
