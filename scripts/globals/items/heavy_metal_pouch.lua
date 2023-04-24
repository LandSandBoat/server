-----------------------------------
-- ID: 5910
-- Heavy Metal Pouch
-- Breaks up a Heavy Metal Pouch
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/items")
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
    target:addItem(xi.items.PLATE_OF_HEAVY_METAL, math.random(3, 19))
end

return itemObject
