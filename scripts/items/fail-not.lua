-----------------------------------
-- ID: 22117, 22131
-- Item: Fail-Not
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getFreeSlotsCount() == 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.CHRONO_ARROW, 99 } }) -- Chrono Arrows x99
end

return itemObject
