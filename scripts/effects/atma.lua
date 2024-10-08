-----------------------------------
-- xi.effect.ATMA
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    xi.atma.onEffectGain(target, effect)
end

effectObject.onEffectTick = function(target, effect)
    if not xi.abyssea.isInAbysseaZone(target) then
        target:delStatusEffect(effect:getEffectType())
    end
end

effectObject.onEffectLose = function(target, effect)
    xi.atma.onEffectLose(target, effect)
end

return effectObject
