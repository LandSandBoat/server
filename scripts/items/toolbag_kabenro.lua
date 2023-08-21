-----------------------------------
-- ID: 5863
-- Toolbag Kaben
-- When used, you will obtain one stack of kabenro
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
    target:addItem(xi.items.KABENRO, 99)
end

return itemObject
