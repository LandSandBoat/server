-----------------------------------------
-- ID: 15957
-- Iron Musketeer's Quiver
-- When used, you will obtain one Iron Musketeer's Bolt
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
    target:addItem(18739)
end
