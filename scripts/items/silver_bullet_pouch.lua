-----------------------------------
-- ID: 5340
-- Silver Bullet Pouch
-- When used, you will obtain one stack of Silver Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.SILVER_BULLET, 99)
end

return itemObject
