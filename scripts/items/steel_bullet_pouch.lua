-----------------------------------
-- ID: 5416
-- Steel Bullet Pouch
-- When used, you will obtain one stack of Steel Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.STEEL_BULLET, 99)
end

return itemObject
