-----------------------------------
-- ID: 5271
-- Old Quiver +1
-- When used, you will obtain one partial stack of Crude Arrows +1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.CRUDE_ARROW_P1, math.random(10, 20))
end

return itemObject
