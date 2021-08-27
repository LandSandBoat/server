-----------------------------------
-- xi.effect.SENGIKORI
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SKILLCHAINDMG, 100)
    target:addMod(xi.mod.UDMGMAGIC, 25)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SKILLCHAINDMG, 100)
    target:delMod(xi.mod.UDMGMAGIC, 25)
end

return effect_object
