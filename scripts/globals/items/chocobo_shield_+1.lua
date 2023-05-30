-----------------------------------
-- ID: 10812
-- Item: Chocobo Shield +1
-- Dispense: Sakura Biscuit
-- Dispenses between 1 and 11 Biscuits
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getFreeSlotsCount() == 0 then
        return xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return 0
end

itemObject.onItemUse = function(target)
    local qty = math.random(1, 11)

    npcUtil.giveItem(target, { { xi.items.SAKURA_BISCUIT, qty } })
end

return itemObject
