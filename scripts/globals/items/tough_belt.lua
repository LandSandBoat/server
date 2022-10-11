-----------------------------------
-- ID: 15864
-- Item: tough_belt
-- Item Effect: VIT +3
-- Duration: 60 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.VIT_BOOST)
    if effect ~= nil and effect:getSubType() == 15864 then
        target:delStatusEffect(xi.effect.VIT_BOOST)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.VIT_BOOST, 3, 0, 60, 15864)
end

return item_object
