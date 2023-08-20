-----------------------------------
-- ID: 5341
-- Spartan Bullet Pouch
-- When used, you will obtain one stack of Spartan Bullets
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
    target:addItem(xi.items.SPARTAN_BULLET, 99)
end

return itemObject
