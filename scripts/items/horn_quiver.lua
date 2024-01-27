-----------------------------------
-- ID: 4222
-- Horn Quiver
-- When used, you will obtain one stack of Horn Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.HORN_ARROW, 99)
end

return itemObject
