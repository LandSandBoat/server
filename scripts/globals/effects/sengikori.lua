-----------------------------------
-- xi.effect.SENGIKORI
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SKILLCHAINDMG, 10000)
    target:addMod(xi.mod.UDMGMAGIC, 2500)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SKILLCHAINDMG, 10000)
    target:delMod(xi.mod.UDMGMAGIC, 2500)
end

return effect_object
