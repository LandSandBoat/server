-----------------------------------
-- ID: 4226
-- Silver Quiver
-- When used, you will obtain one stack of Silver Arrows
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
    target:addItem(xi.items.SILVER_ARROW, 99)
end

return itemObject
