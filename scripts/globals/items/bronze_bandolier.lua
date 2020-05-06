-----------------------------------------
-- ID: 15926
-- bronze_bandolier
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
    target:addItem(17343, 99) -- bronze_bullet
end
