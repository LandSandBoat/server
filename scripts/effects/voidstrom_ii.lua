-----------------------------------
-- xi.effect.VOIDSTORM_II
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = math.floor(effect:getPower() / 2)
    effect:addMod(xi.mod.STR, power)
    effect:addMod(xi.mod.DEX, power)
    effect:addMod(xi.mod.VIT, power)
    effect:addMod(xi.mod.AGI, power)
    effect:addMod(xi.mod.INT, power)
    effect:addMod(xi.mod.MND, power)
    effect:addMod(xi.mod.CHR, power)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
