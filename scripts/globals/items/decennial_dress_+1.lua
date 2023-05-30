-----------------------------------
-- ID: 10254
-- Decennial Dress +1
-- Dispense: Bowl of Moogurt
-- Dispenses between 2 and 10 Moogurts
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
    local qty = math.random(2, 10)

    npcUtil.giveItem(target, { { xi.items.BOWL_OF_MOOGURT, qty } })
end

return itemObject
