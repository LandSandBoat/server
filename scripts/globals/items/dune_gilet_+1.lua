-----------------------------------
-- ID: 10271
-- Dune Gilet +1
-- Dispense: Berry Snowcone
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
    target:addItem(xi.items.BERRY_SNOW_CONE, 1)
end

return itemObject
