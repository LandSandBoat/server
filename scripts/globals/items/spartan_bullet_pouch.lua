-----------------------------------
-- ID: 5341
-- Spartan Bullet Pouch
-- When used, you will obtain one stack of Spartan Bullets
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
    target:addItem(18160, 99)
end

return item_object
