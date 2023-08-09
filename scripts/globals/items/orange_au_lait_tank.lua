-----------------------------------
--  ID: 16223
--  Orange au lait Tank
--  When used, you will obtain one Orange au lait
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/items")
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
    target:addItem(xi.items.FLASK_OF_ORANGE_AU_LAIT, 1)
end

return itemObject
