-----------------------------------
-- ID: 4110
-- Light Cluster
-- Turn into a stack of light crystals
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.LIGHT_CRYSTAL, 12)
end

return itemObject
