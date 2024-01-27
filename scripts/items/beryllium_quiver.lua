-----------------------------------
-- ID: 6418
-- Beryllium Quiver
-- When used, you will obtain one stack of Beryllium Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BERYLLIUM_ARROW, 99)
end

return itemObject
