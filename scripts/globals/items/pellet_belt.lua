-----------------------------------------
--   ID: 15288
--   Pellet Belt
--   When used, you will obtain 12 Pebbles
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
    target:addItem(17296, 12)
end
