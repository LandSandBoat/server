-----------------------------------
-- xi.effect.AFFLATUS_SOLACE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AFFLATUS_SOLACE, 0)
    target:addMod(xi.mod.BARSPELL_MDEF_BONUS, 5)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AFFLATUS_SOLACE, 0)
    target:delMod(xi.mod.BARSPELL_MDEF_BONUS, 5)
end

return effect_object
