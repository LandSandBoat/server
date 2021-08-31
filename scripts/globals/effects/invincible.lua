-----------------------------------
-- xi.effect.INVINCIBLE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.UDMGPHYS, -10000)
    target:addMod(xi.mod.UDMGRANGE, -10000)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.UDMGPHYS, -10000)
    target:delMod(xi.mod.UDMGRANGE, -10000)
end

return effect_object
