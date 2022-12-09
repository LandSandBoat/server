-----------------------------------
-- ID: 16120
-- redeyes
-----------------------------------
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
    target:addItem(5441, 99) -- Angelwing x99
    target:messageBasic(xi.msg.basic.ITEM_OBTAINED, 5441)
end

return itemObject
