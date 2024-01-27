-----------------------------------
-- ID: 5403
-- Ice Card Case
-- When used, you will obtain one stack of Ice Cards
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.ICE_CARD, 99)
end

return itemObject
