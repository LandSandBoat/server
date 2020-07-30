------------------------------------
-- ID: 5736
-- Lin. Purse (Alx.)
-- Breaks up a Linen Purse
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
    target:addItem(2488, math.random(50, 99))
end
