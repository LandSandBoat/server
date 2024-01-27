-----------------------------------
-- ID: 5404
-- Wind Card Case
-- When used, you will obtain one stack of Wind Cards
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.WIND_CARD, 99)
end

return itemObject
