-----------------------------------
-- ID: 5315
-- Toolbag Jusa
-- When used, you will obtain one stack of jusatsu
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
    target:addItem(xi.items.JUSATSU, 99)
end

return itemObject
