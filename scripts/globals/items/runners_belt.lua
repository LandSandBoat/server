-----------------------------------
-- ID: 15865
-- Item: runners_belt
-- Item Effect: DEX +3
-- Duration: 60 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.DEX_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.items.RUNNERS_BELT then
        target:delStatusEffect(xi.effect.DEX_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.DEX_BOOST, 3, 0, 60, 0, 0, 0, xi.items.RUNNERS_BELT)
end

return itemObject
