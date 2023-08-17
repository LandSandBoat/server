-----------------------------------
-- ID: 26546
-- Moogle Shirt
-- Dispense: Porcelain Mine
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/items")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.items.PORCELAIN_MINE, 99 } })
end

return itemObject
