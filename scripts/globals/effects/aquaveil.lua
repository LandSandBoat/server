-----------------------------------
-- xi.effect.AQUAVEIL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SPELLINTERRUPT, 20)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SPELLINTERRUPT, 20)
end

return effectObject
