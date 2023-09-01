-----------------------------------
-- ID: 15927
-- pinwheel_belt
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.PINWHEEL, 99) -- pinwheel
end

return itemObject
