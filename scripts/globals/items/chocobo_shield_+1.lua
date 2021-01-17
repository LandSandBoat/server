-----------------------------------------
-- ID: 10812
-- Item: Chocobo Shield +1
-- Dispense: Sakura Biscuit
-----------------------------------------
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getFreeSlotsCount() == 0 then
        return tpz.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addItem(6010, 1)
end

return item_object
