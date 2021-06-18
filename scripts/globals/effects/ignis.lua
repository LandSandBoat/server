-----------------------------------
-- xi.effect.IGNIS
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ENSPELL, xi.magic.element.FIRE)
    target:addMod(xi.mod.ENSPELL_DMG, effect:getPower())
    target:addMod(xi.mod.ICERES, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ENSPELL, xi.magic.element.FIRE)
    target:delMod(xi.mod.ENSPELL_DMG, effect:getPower())
    target:delMod(xi.mod.ICERES, effect:getPower())
end

return effect_object
