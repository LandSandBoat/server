-----------------------------------
-- ID: 5407
-- Water Card Case
-- When used, you will obtain one stack of Water Cards
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.WATER_CARD, 99)
end

return itemObject
