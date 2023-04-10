-----------------------------------
-- ID: 6415
-- Seki Shuriken Pouch
-- When used, you will obtain one stack of Seki Shurikens
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/msg")
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
    target:addItem(xi.items.SEKI_SHURIKEN, 99)
end

return itemObject
