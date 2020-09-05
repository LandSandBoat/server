-----------------------------------------
-- ID: 5342
-- Corsair Bullet Pouch
-- When used, you will obtain one stack of Corsair Bullets
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
    target:addItem(18235, 99)
end
