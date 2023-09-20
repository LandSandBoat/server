-----------------------------------
-- ID: 6185
-- Boulder Box
-- Breaks up a Boulder Box
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.RIFTBORN_BOULDER, math.random(15, 30))
end

return itemObject
