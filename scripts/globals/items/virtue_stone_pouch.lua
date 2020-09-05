-----------------------------------------
-- ID: 5410
-- virtue_stone_pouch.lua
-- When used, you will obtain one stack of virtue stone
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
    target:addItem(18244, 99)
end

