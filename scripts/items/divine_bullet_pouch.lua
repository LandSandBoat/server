-----------------------------------
-- ID: 6437
-- Divine Bullet Pouch
-- When used, you will obtain one stack of Divine Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.DIVINE_BULLET, 99)
end

return itemObject
