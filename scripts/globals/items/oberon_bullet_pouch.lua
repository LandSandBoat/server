-----------------------------------------
-- ID: 5822
-- Oberon Bullet Pouch
-- When used, you will obtain one stack of Oberon Bullets
-----------------------------------------
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = tpz.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

item_object.onItemUse = function(target)
    target:addItem(19199, 99)
end

return item_object
