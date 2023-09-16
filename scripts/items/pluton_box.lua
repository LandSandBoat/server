-----------------------------------
-- ID: 6183
-- Pluton Box
-- Breaks up a Pluton Box
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.PLUTON, math.random(15, 30))
end

return itemObject
