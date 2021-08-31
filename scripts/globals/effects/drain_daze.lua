-----------------------------------
-- xi.effect.DRAIN_DAZE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ENSPELL_DMG, 0)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setMod(xi.mod.ENSPELL_DMG, 0)
end

return effect_object
