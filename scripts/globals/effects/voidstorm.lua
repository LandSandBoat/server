-----------------------------------
-- xi.effect.VOIDSTORM
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, math.floor(effect:getPower() / 2))
    target:addMod(xi.mod.DEX, math.floor(effect:getPower() / 2))
    target:addMod(xi.mod.VIT, math.floor(effect:getPower() / 2))
    target:addMod(xi.mod.AGI, math.floor(effect:getPower() / 2))
    target:addMod(xi.mod.INT, math.floor(effect:getPower() / 2))
    target:addMod(xi.mod.MND, math.floor(effect:getPower() / 2))
    target:addMod(xi.mod.CHR, math.floor(effect:getPower() / 2))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, math.floor(effect:getPower() / 2))
    target:delMod(xi.mod.DEX, math.floor(effect:getPower() / 2))
    target:delMod(xi.mod.VIT, math.floor(effect:getPower() / 2))
    target:delMod(xi.mod.AGI, math.floor(effect:getPower() / 2))
    target:delMod(xi.mod.INT, math.floor(effect:getPower() / 2))
    target:delMod(xi.mod.MND, math.floor(effect:getPower() / 2))
    target:delMod(xi.mod.CHR, math.floor(effect:getPower() / 2))
end

return effectObject
