-----------------------------------
-- ID: 5278
-- Old Bolt Box
-- When used, you will obtain one partial stack of Dogbolt
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
    target:addItem(18189, math.random(10, 20))
end

return itemObject
