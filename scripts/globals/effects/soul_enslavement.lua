-----------------------------------
-- xi.effect.SOUL_ENSLAVEMENT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ENSPELL, 22)
    target:addMod(xi.mod.ENSPELL_DMG, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ENSPELL, 22)
    target:delMod(xi.mod.ENSPELL_DMG, 0)
end

return effectObject
