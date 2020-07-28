------------------------------------
-- ID: 5910
-- Heavy Metal Pouch
-- Breaks up a Heavy Metal Pouch
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
    target:addItem(3509, math.random(3, 19))
end
