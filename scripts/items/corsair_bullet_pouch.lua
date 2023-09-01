-----------------------------------
-- ID: 5342
-- Corsair Bullet Pouch
-- When used, you will obtain one stack of Corsair Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.CORSAIR_BULLET, 99)
end

return itemObject
