-----------------------------------
-- ID: 11002
-- Dragon Tank
-- Dispense: Flask of Dragon Fruit au Lait
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.FLASK_OF_DRAGON_FRUIT_AU_LAIT, 1)
end

return itemObject
