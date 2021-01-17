-----------------------------------------
-- ID: 5273
-- Old Quiver +3
-- When used, you will obtain one partial stack of Crude Arrows +3
-----------------------------------------
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = tpz.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

item_object.onItemUse = function(target)
    target:addItem(18184, math.random(99))
end

return item_object
