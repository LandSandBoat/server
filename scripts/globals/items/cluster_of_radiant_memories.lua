-----------------------------------------
-- ID: 5292
-- Cluster of Radiant Memories
-- Turn into a stack of radiant memories
-----------------------------------------
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

item_object.onItemUse = function(target)
    target:addItem(1612, 12)
end

return item_object
