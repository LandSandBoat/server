-----------------------------------------
--  ID: 16225
--  Pear au lait Tank
--  When used, you will obtain one Pear au lait
-----------------------------------------
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = tpz.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

function onItemUse(target)
    target:addItem(4301, 1)
end
