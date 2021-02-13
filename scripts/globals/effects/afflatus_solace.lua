-----------------------------------
-- tpz.effect.AFFLATUS_SOLACE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.AFFLATUS_SOLACE, 0)
    target:addMod(tpz.mod.BARSPELL_MDEF_BONUS, 5)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.AFFLATUS_SOLACE, 0)
    target:delMod(tpz.mod.BARSPELL_MDEF_BONUS, 5)
end

return effect_object
