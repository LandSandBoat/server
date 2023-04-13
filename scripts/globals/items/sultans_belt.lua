-----------------------------------
-- ID: 15867
-- Item: sultans_belt
-- Item Effect: STR +10
-- Duration: 60 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.STR_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.items.SULTANS_BELT then
        target:delStatusEffect(xi.effect.STR_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.SULTANS_BELT) then
        target:addStatusEffect(xi.effect.STR_BOOST, 10, 0, 60, 0, 0, 0, xi.items.SULTANS_BELT)
    end
end

return itemObject
