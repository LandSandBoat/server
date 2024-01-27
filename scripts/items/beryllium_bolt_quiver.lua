-----------------------------------
-- ID: 6428
-- Beryllium Bolt Quiver
-- When used, you will obtain one stack of Beryllium Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BERYLLIUM_BOLT, 99)
end

return itemObject
