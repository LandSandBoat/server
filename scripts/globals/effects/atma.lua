-----------------------------------
-- xi.effect.ATMA
-----------------------------------
require("scripts/globals/abyssea/atma")
require("scripts/globals/abyssea")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    xi.atma.onEffectGain(target, effect)
end

effectObject.onEffectTick = function(target, effect)
    if not xi.abyssea.isInAbysseaZone(target) then
        target:delStatusEffect(effect)
    end
end

effectObject.onEffectLose = function(target, effect)
    xi.atma.onEffectLose(target, effect)
end

return effectObject
