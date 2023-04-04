-----------------------------------
-- ID: 15869
-- Item: pendragons_belt
-- Item Effect: DEX +10
-- Duration: 60 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.DEX_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.items.PENDRAGONS_BELT then
        target:delStatusEffect(xi.effect.DEX_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.PENDRAGONS_BELT) then
        target:addStatusEffect(xi.effect.DEX_BOOST, 10, 0, 60, 0, 0, 0, xi.items.PENDRAGONS_BELT)
    end
end

return itemObject
