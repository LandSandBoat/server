-----------------------------------
-- xi.effect.VISITANT
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local visEffect = target:getStatusEffect(xi.effect.VISITANT)

    visEffect:setFlag(xi.effectFlag.ON_ZONE)
    visEffect:setFlag(xi.effectFlag.INFLUENCE)
end

effect_object.onEffectTick = function(target, effect)
	if not xi.abyssea.isInAbysseaZone(target) then
        target:delStatusEffect(effect)
    end

    -- Searing Ward Tether is set and reset in zone onRegionLeave and
    -- onRegionEnter.
    if target:getLocalVar('tetherTimer') == 11 then
        xi.abyssea.searingWardTimer(target)
    end
end

effect_object.onEffectLose = function(target, effect)
    -- if xi.abyssea.isInAbysseaZone(target) then
    --     target:warp()
    -- end
end

return effect_object
