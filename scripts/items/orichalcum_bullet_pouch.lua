-----------------------------------
-- ID: 5914
-- Orichalcum Bullet Pouch
-- When used, you will obtain one stack of Orichalcum Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.ORICHALCUM_BULLET, 99)
end

return itemObject
