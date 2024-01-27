-----------------------------------
-- ID: 5363
-- Item: Bullet Pouch
-- When used, you will obtain one stack of Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BULLET, 99)
end

return itemObject
