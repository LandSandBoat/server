-----------------------------------
-- xi.effect.VISITANT
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    -- Remove any older dedication effect
    if target:hasStatusEffect(xi.effect.DEDICATION) then
        target:delStatusEffect(xi.effect.DEDICATION)
    end

    target:addStatusEffect(xi.effect.DEDICATION,10,3,0,0,5000000)
    local expEffect = target:getStatusEffect(xi.effect.DEDICATION)
    local visEffect = target:getStatusEffect(xi.effect.VISITANT)
    expEffect:setFlag(xi.effectFlag.ON_ZONE)
    visEffect:setFlag(xi.effectFlag.ON_ZONE)
    visEffect:setFlag(xi.effectFlag.INFLUENCE)
    expEffect:setFlag(xi.effectFlag.INFLUENCE)
	target:setLocalVar("[WasInAbyssea]", 1)
end

effect_object.onEffectTick = function(target, effect)
	if not xi.abyssea.isInAbysseaZone(target) then
        target:delStatusEffect(effect)
    end

	if not target:hasStatusEffect(xi.effect.DEDICATION) then
		target:addStatusEffect(xi.effect.DEDICATION,10,3,0,0,5000000)
		local expEffect = target:getStatusEffect(xi.effect.DEDICATION)
		expEffect:setFlag(xi.effectFlag.ON_ZONE)
		expEffect:setFlag(xi.effectFlag.INFLUENCE)
    end

    local expRate = 60 + math.floor(target:getCharVar("goldLight") * 4.33 / 1.9)
    target:getStatusEffect(xi.effect.DEDICATION):setPower(expRate)
end

effect_object.onEffectLose = function(target, effect)
    if xi.abyssea.isInAbysseaZone(target) then
        target:warp()
    end
end

return effect_object
