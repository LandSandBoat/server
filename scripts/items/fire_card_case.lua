-----------------------------------
-- ID: 5402
-- Fire Card Case
-- When used, you will obtain one stack of Fire Cards
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
    target:addItem(xi.items.FIRE_CARD, 99)
end

return itemObject
