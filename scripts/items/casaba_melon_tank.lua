-----------------------------------
--  ID: 13682
--  Casaba Melon Tank
--  When used, you will obtain a Melon Juice
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BOTTLE_OF_MELON_JUICE, 1)
end

return itemObject
