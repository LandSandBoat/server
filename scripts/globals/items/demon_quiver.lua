-----------------------------------
-- ID: 4224
-- Demon Quiver
-- When used, you will obtain one stack of Demon Arrows
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
    target:addItem(xi.items.DEMON_ARROW, 99)
end

return itemObject
