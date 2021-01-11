-----------------------------------
-- tpz.effect.COMPOSURE
-- Increases accuracy and lengthens recast time. Enhancement effects gained through white
-- and black magic you cast on yourself last longer.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ACC, 15)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ACC, 15)
end

return effect_object
