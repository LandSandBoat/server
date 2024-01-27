-----------------------------------
-- ID: 5820
-- Darkling Bolt Quiver
-- When used, you will obtain one stack of Darkling Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.DARKLING_BOLT, 99)
end

return itemObject
