-----------------------------------
-- ID: 4221
-- Item: Beetle Quiver
-- When used, you will obtain one stack of Beetle Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BEETLE_ARROW, 99)
end

return itemObject
