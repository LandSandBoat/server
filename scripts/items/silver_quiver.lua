-----------------------------------
-- ID: 4226
-- Silver Quiver
-- When used, you will obtain one stack of Silver Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.SILVER_ARROW, 99)
end

return itemObject
