-----------------------------------------
-- ID: 5288
-- Fleeting Cluster
-- Turn into a stack of fleeting memories
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
    target:addItem(1608, 12)
end

return itemObject
