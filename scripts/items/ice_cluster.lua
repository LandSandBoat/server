-----------------------------------
-- ID: 4105
-- Ice Cluster
-- Turn into a stack of ice crystals
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.ICE_CRYSTAL, 12)
end

return itemObject
