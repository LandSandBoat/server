-----------------------------------------
-- ID: 13688
-- Hi-Potion Tank
-- When used, you will obtain one Hi-Potion
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
    target:addItem(4116, 1)
end
