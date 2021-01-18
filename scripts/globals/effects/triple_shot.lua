-----------------------------------
-- tpz.effect.TRIPLE_SHOT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.EXTRA_DMG_CHANCE, 19)
    target:addMod(tpz.mod.OCC_DO_EXTRA_DMG, 300)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.EXTRA_DMG_CHANCE, 19)
    target:delMod(tpz.mod.OCC_DO_EXTRA_DMG, 300)
end

return effect_object
