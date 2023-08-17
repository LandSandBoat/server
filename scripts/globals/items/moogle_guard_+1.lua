-----------------------------------
-- ID: 10810
-- Item: Moogle Guard +1
-- Dispense: Mog Pudding
-- Dispenses between 1 and 12 Mog Puddings
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getFreeSlotsCount() == 0 then
        return xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return 0
end

itemObject.onItemUse = function(target)
    local qty = math.random(1, 12)

    npcUtil.giveItem(target, { { xi.items.MOG_PUDDING, qty } })
end

return itemObject
