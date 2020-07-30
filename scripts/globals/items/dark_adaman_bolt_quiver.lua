-----------------------------------------
-- ID: 5872
-- Dark Adaman Bolt Quiver
-- When used, you will obtain one stack of Dark Adaman Bolts
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
    target:addItem(19183, 99)
end
