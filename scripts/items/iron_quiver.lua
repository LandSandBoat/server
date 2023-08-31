-----------------------------------
-- ID: 4225
-- Iron Quiver
-- When used, you will obtain one stack of Iron Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.IRON_ARROW, 99)
end

return itemObject
