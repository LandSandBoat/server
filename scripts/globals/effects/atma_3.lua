-----------------------------------
-- xi.effect.ATMA
-----------------------------------
require("scripts/globals/atma")
require("scripts/globals/abyssea")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    xi.atma.onEffectGain(target, effect)
end

effect_object.onEffectTick = function(target, effect)
	if not xi.abyssea.isInAbysseaZone(target) then
        target:delStatusEffect(effect)
    end
end

effect_object.onEffectLose = function(target, effect)
    xi.atma.onEffectLose(target, effect)
end

return effect_object
