local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.SHOCK_SPIKES)
    if effect ~= nil and effect:getSubType() == 15650 then
        target:delStatusEffect(xi.effect.SHOCK_SPIKES)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.SHOCK_SPIKES, 15, 0, 180, 15650)
end

return item_object
