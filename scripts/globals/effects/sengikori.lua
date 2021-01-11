----------------------------------------
-- tpz.effect.SENGIKORI
----------------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.SKILLCHAINDMG, 100)
    target:addMod(tpz.mod.UDMGMAGIC, 25)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.SKILLCHAINDMG, 100)
    target:delMod(tpz.mod.UDMGMAGIC, 25)
end

return effect_object
