-----------------------------------
-- ID: 5914
-- Orichalcum Bullet Pouch
-- When used, you will obtain one stack of Orichalcum Bullets
-----------------------------------
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
    target:addItem(19802, 99)
end

return itemObject
