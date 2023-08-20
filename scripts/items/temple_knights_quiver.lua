-----------------------------------
-- ID: 15956
-- Temple Knight's Quiver
-- When used, you will obtain one Temple Knight's Arrow
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
    target:addItem(xi.items.TEMPLE_KNIGHTS_ARROW)
end

return itemObject
