-----------------------------------
-- ID: 15179
-- Dream Hat +1
-- Dispenses Ginger Cookies
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
    target:addItem(xi.items.GINGER_COOKIE, math.random(1, 10))
end

return itemObject
