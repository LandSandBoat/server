-----------------------------------
-- ID: 4111
-- Dark Cluster
-- Turn into a stack of dark crystals
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.DARK_CRYSTAL, 12)
end

return itemObject
