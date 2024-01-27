-----------------------------------
-- ID: 15453
-- lugworm_belt
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.LUGWORM, 12)
end

return itemObject
