-----------------------------------
-- ID: 4107
-- Earth Cluster
-- Turn into a stack of earth crystals
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = tpz.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

item_object.onItemUse = function(target)
    target:addItem(4099, 12)
end

return item_object
