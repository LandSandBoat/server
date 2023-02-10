-----------------------------------
-- ID: 11002
-- Dragon Tank
-- Dispense: Flask of Dragon Fruit au Lait
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addItem(xi.items.FLASK_OF_DRAGON_FRUIT_AU_LAIT, 1)
end

return itemObject
