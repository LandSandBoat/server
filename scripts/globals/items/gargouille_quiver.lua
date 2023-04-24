-----------------------------------
-- ID: 5912
-- Gargouille Quiver
-- When used, you will obtain one stack of Gargouille Arrow
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
    target:addItem(xi.items.GARGOUILLE_ARROW, 99)
end

return itemObject
