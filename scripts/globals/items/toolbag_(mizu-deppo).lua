-----------------------------------------
-- ID: 5313
-- Toolbag Mizu
-- When used, you will obtain one stack of mizu-deppo
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
    target:addItem(1176, 99)
end

