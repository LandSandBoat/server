-----------------------------------
-- ID: 6417
-- Divine Quiver
-- When used, you will obtain one stack of Divine Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.DIVINE_ARROW, 99)
end

return itemObject
