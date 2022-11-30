-----------------------------------
-- ID: 5337
-- Sleep Bolt Quiver
-- When used, you will obtain one stack of Sleep Bolts
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
    target:addItem(18149, 99)
end

return itemObject
