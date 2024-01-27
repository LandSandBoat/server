-----------------------------------
-- ID: 6427
-- Divine Volt Quiver
-- When used, you will obtain one stack of Divine Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.DIVINE_BOLT, 99)
end

return itemObject
