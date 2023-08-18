-----------------------------------
-- ID: 5279
-- Old Bolt Box +1
-- When used, you will obtain one partial stack of Dogbolt +1
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/items")
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
    target:addItem(xi.items.DOGBOLT_P1, math.random(10, 20))
end

return itemObject
