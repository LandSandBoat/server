-----------------------------------
-- ID: 15864
-- Item: tough_belt
-- Item Effect: VIT +3
-- Duration: 60 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.VIT_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.items.TOUGH_BELT then
        target:delStatusEffect(xi.effect.VIT_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.TOUGH_BELT) then
        target:addStatusEffect(xi.effect.VIT_BOOST, 3, 0, 60, 0, 0, 0, xi.items.TOUGH_BELT)
    end
end

return itemObject
