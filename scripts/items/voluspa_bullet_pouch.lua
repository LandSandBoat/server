-----------------------------------
-- ID: 6438
-- Voluspa Bullet Pouch
-- When used, you will obtain one stack of Voluspa Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.VOLUSPA_BULLET, 99)
end

return itemObject
