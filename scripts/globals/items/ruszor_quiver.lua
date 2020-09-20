-----------------------------------------
-- ID: 5871
-- Ruszor Quiver
-- When used, you will obtain one stack of Ruszor Arrows
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
    target:addItem(19182, 99)
end
