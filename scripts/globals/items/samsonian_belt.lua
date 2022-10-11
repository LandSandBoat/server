-----------------------------------
-- ID: 15863
-- Item: samsonian_belt
-- Item Effect: STR +3
-- Duration: 60 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.STR_BOOST)
    if effect ~= nil and effect:getSubType() == 15863 then
        target:delStatusEffect(xi.effect.STR_BOOST)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.STR_BOOST, 3, 0, 60, 15863)
end

return item_object
