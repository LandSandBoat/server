-----------------------------------
-- ID: 20953
-- Escritorio
-- Dispense: Cone Calamary
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.CONE_CALAMARY, 1)
end

return itemObject
