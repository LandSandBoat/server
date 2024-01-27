-----------------------------------
-- ID: 6419
-- Raetic Quiver
-- When used, you will obtain one stack of Raetic Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.RAETIC_ARROW, 99)
end

return itemObject
