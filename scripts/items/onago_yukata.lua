-----------------------------------
-- ID: 14533
-- onago_yukata
-- Dispense: Muteppo x99
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
    target:addItem(xi.items.MUTEPPO, 99)
end

return itemObject
