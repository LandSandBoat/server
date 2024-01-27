-----------------------------------
-- ID: 15454
-- little_worm_belt
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.LITTLE_WORM, 12)
end

return itemObject
