-----------------------------------
-- ID: 5342
-- Corsair Bullet Pouch
-- When used, you will obtain one stack of Corsair Bullets
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
    target:addItem(xi.items.CORSAIR_BULLET, 99)
end

return itemObject
