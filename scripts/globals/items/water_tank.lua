-----------------------------------
--  ID: 13683
--  Water Tank
--  When used, you will obtain one stack of Distilled Water
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
    target:addItem(xi.items.FLASK_OF_DISTILLED_WATER, 12)
end

return itemObject
