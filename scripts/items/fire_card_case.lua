-----------------------------------
-- ID: 5402
-- Fire Card Case
-- When used, you will obtain one stack of Fire Cards
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.FIRE_CARD, 99)
end

return itemObject
