-----------------------------------
-- ID: 5913
-- Adaman Bolt Quiver
-- When used, you will obtain one stack of Adaman Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.ADAMAN_BOLT, 99)
end

return itemObject
