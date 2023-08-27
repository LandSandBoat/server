-----------------------------------------
-- ID: 5290
-- Cluster of Startling Memories
-- Turn into a stack of startling memories
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
    target:addItem(1610, 12)
end

return itemObject
