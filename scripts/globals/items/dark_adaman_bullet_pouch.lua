-----------------------------------
-- ID: 5873
-- Dark Adaman Bullet Pouch
-- When used, you will obtain one stack of Dark Adaman Bullets
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

item_object.onItemUse = function(target)
    target:addItem(19184, 99)
end

return item_object
