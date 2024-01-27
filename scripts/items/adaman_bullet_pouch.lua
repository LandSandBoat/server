-----------------------------------
-- ID: 5915
-- Adaman Bullet Pouch
-- When used, you will obtain one stack of Adaman Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.ADAMAN_BULLET, 99)
end

return itemObject
