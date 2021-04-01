-----------------------------------
-- xi.effect.TRIPLE_SHOT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.EXTRA_DMG_CHANCE, 19)
    target:addMod(xi.mod.OCC_DO_EXTRA_DMG, 300)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.EXTRA_DMG_CHANCE, 19)
    target:delMod(xi.mod.OCC_DO_EXTRA_DMG, 300)
end

return effect_object
