-----------------------------------------
-- ID: 5819
-- Item: Antlion Quiver
-- When used, you will obtain one stack of Antlion Arrows
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
    target:addItem(19195, 99)
end
