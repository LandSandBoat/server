-----------------------------------
-- ID: 5359
-- Item: Bronze Bullet Pouch
-- When used, you will obtain one stack of Bronze Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BRONZE_BULLET, 99)
end

return itemObject
