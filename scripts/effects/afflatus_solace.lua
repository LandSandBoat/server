-----------------------------------
-- xi.effect.AFFLATUS_SOLACE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AFFLATUS_SOLACE, 0)
    target:addMod(xi.mod.BARSPELL_MDEF_BONUS, 5)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AFFLATUS_SOLACE, 0)
    target:delMod(xi.mod.BARSPELL_MDEF_BONUS, 5)
end

return effectObject
