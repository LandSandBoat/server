-----------------------------------
-- ID: 5409
-- Dark Card Case
-- When used, you will obtain one stack of Dark Cards
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.DARK_CARD, 99)
end

return itemObject
