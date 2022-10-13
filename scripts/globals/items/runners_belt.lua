-----------------------------------
-- ID: 15865
-- Item: runners_belt
-- Item Effect: DEX +3
-- Duration: 60 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.DEX_BOOST)
    if effect ~= nil and effect:getSubType() == 15865 then
        target:delStatusEffect(xi.effect.DEX_BOOST)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.DEX_BOOST, 3, 0, 60, 15865)
end

return item_object
