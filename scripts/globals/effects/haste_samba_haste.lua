-----------------------------------
-- xi.effect.HASTE_SAMBA_HASTE
-- JA Haste 5-10%
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HASTE_ABILITY, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HASTE_ABILITY, effect:getPower())
end

return effectObject
