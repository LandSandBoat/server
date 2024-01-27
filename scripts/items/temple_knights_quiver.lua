-----------------------------------
-- ID: 15956
-- Temple Knight's Quiver
-- When used, you will obtain one Temple Knight's Arrow
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.TEMPLE_KNIGHTS_ARROW)
end

return itemObject
