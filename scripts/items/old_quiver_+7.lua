-----------------------------------
-- ID: 5277
-- Old Quiver +7
-- When used, you will obtain one partial stack of Crude Arrows +7
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.CRUDE_ARROW_P7, math.random(10, 20))
end

return itemObject
