-----------------------------------
-- ID: 5271
-- Old Quiver +1
-- When used, you will obtain one partial stack of Crude Arrows +1
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
    target:addItem(18182, math.random(10, 20))
end

return itemObject
