-----------------------------------
-- ID: 15867
-- Item: sultans_belt
-- Item Effect: STR +10
-- Duration: 60 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.STR_BOOST)
    if effect ~= nil and effect:getSubType() == 15867 then
        target:delStatusEffect(xi.effect.STR_BOOST)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.STR_BOOST, 10, 0, 60, 15867)
end

return item_object
