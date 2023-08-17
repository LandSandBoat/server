-----------------------------------
-- ID: 10433
-- Decennial Tiara +1
-- Dispense: Chocobiscuit
-- Despenses between 1 and 10 Chocobiscuits
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
    local qty = math.random(1, 10)

    npcUtil.giveItem(target, { { xi.items.CHOCOBISCUIT, qty } })
end

return itemObject
