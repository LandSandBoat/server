-----------------------------------
-- ID: 4106
-- Wind Cluster
-- Turn into a stack of wind crystals
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.WIND_CRYSTAL, 12)
end

return itemObject
