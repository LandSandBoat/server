-----------------------------------
-- ID: 15651
-- Item: Ice Trousers
-- Item Effect: Ice Spikes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ICE_SPIKES, 15, 0, 180, 0, 0, 0, xi.items.ICE_TROUSERS)
end

return itemObject
