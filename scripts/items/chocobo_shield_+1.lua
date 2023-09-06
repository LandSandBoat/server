-----------------------------------
-- ID: 10812
-- Item: Chocobo Shield +1
-- Dispense: Sakura Biscuit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.SAKURA_BISCUIT, 1)
end

return itemObject
