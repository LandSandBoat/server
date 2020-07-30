-----------------------------------------
-- ID: 6447
-- Sasu. Sh. Pouch
-- A small leather pouch made for storing sasuke shuriken.
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
    target:addItem(22276, 99)
end

