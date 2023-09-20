-----------------------------------
-- ID: 6184
-- Beitetsu Box
-- Breaks up a Beitetsu Box
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BEITETSU, math.random(15, 30))
end

return itemObject
