-----------------------------------
-- ID: 5336
-- Holy Bolt Quiver
-- When used, you will obtain one stack of Holy Bolts
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
    target:addItem(18153, 99)
end

return itemObject
