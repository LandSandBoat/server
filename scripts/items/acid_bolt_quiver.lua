-----------------------------------
-- ID: 5335
-- Item: Acid Bolt Quiver
-- When used, you will obtain one stack of Acid Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.ACID_BOLT, 99)
end

return itemObject
