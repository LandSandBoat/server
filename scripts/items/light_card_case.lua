-----------------------------------
-- ID: 5408
-- Light Card Case
-- When used, you will obtain one stack of Light Cards
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.LIGHT_CARD, 99)
end

return itemObject
