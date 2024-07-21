-----------------------------------
-- xi.effect.SOUL_ENSLAVEMENT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:delStatusEffectSilent(xi.effect.AUSPICE)
    target:delStatusEffectSilent(xi.effect.ENSTONE)
    target:delStatusEffectSilent(xi.effect.ENSTONE_II)
    target:delStatusEffectSilent(xi.effect.ENWATER)
    target:delStatusEffectSilent(xi.effect.ENWATER_II)
    target:delStatusEffectSilent(xi.effect.ENAERO)
    target:delStatusEffectSilent(xi.effect.ENAERO_II)
    target:delStatusEffectSilent(xi.effect.ENFIRE)
    target:delStatusEffectSilent(xi.effect.ENFIRE_II)
    target:delStatusEffectSilent(xi.effect.ENBLIZZARD)
    target:delStatusEffectSilent(xi.effect.ENBLIZZARD_II)
    target:delStatusEffectSilent(xi.effect.ENTHUNDER)
    target:delStatusEffectSilent(xi.effect.ENTHUNDER_II)
    target:delStatusEffectSilent(xi.effect.ENLIGHT)
    target:delStatusEffectSilent(xi.effect.ENDARK)

    effect:addMod(xi.mod.ENSPELL, 22)
    effect:addMod(xi.mod.ENSPELL_DMG, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
