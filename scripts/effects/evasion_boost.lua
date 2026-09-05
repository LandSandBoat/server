-----------------------------------
-- xi.effect.EVASION_BOOST
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getSubType() == 1 then
        target:addMod(xi.mod.EVA_PERCENT, effect:getPower())
    else
        target:addMod(xi.mod.EVA, effect:getPower())
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    if effect:getSubType() == 1 then
        target:delMod(xi.mod.EVA_PERCENT, effect:getPower())
    else
        target:delMod(xi.mod.EVA, effect:getPower())
    end
end

return effectObject
