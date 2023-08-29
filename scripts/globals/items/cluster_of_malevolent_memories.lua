-----------------------------------------
-- ID: 5293
-- Cluster of Malevolent Memories
-- Turn into a stack of malevolent memories
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

itemObject.onItemUse = function(target)
    target:addItem(1613, 12)
end

return itemObject
