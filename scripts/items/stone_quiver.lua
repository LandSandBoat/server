-----------------------------------
-- ID: 4219
-- Stone Quiver
-- When used, you will obtain one stack of Stone Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.STONE_ARROW, 99)
end

return itemObject
