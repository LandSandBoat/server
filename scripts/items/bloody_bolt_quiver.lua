-----------------------------------
-- ID: 5339
-- Item: Bloody Bolt Quiver
-- When used, you will obtain one stack of Bloody Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BLOODY_BOLT, 99)
end

return itemObject
