-----------------------------------
-- ID: 5353
-- Iron Bullet Pouch
-- When used, you will obtain one stack of Iron Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.IRON_BULLET, 99)
end

return itemObject
