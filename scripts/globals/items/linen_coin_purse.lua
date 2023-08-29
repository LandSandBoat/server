-----------------------------------
-- ID: 5736
-- Lin. Purse (Alx.)
-- Breaks up a Linen Purse
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
    target:addItem(xi.items.ALEXANDRITE, math.random(50, 99))
end

return itemObject
