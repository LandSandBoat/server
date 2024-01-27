-----------------------------------
-- ID: 15300
-- nebimonite_belt
-- Dispense: Nebimonite
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.NEBIMONITE)
end

return itemObject
