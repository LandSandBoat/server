-----------------------------------
--  ID: 13682
--  Casaba Melon Tank
--  When used, you will obtain a Melon Juice
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
    target:addItem(xi.items.BOTTLE_OF_MELON_JUICE, 1)
end

return itemObject
