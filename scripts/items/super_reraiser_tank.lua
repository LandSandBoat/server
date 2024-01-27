-----------------------------------
-- ID: 26272
-- Super Reraiser Tank
-- When used, you will obtain one super reraiser
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.SUPER_RERAISER, 1)
end

return itemObject
