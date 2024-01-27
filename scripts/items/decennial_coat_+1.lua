-----------------------------------
-- ID: 10253
-- Decennial Coat +1
-- Dispense: Bowl of Moogurt
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BOWL_OF_MOOGURT, 1)
end

return itemObject
