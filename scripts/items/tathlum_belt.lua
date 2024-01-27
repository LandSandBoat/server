-----------------------------------
-- ID: 15296
-- tathlum_belt
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.TATHLUM, 8) -- tathlum
end

return itemObject
