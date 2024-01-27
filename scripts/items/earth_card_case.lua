-----------------------------------
-- ID: 5405
-- Earth Card Case
-- When used, you will obtain one stack of Earth Cards
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.EARTH_CARD, 99)
end

return itemObject
