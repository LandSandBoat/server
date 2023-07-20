-----------------------------------
-- ID: 5869
-- Toolbag Cho
-- When used, you will obtain one stack of chonofuda
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
    target:addItem(xi.items.CHONOFUDA, 99)
end

return itemObject
