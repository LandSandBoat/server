-----------------------------------
-- xi.effect.PROWESS
-- Treasure Hunter bonus
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.TREASURE_HUNTER, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.TREASURE_HUNTER, effect:getPower())
end

return effectObject
