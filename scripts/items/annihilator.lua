-----------------------------------
-- ID: 18336, 18337, 18649, 18663, 18677, 19758, 19851, 21260, 21261, 21267
-- Item: Annihilator
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getFreeSlotsCount() == 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ERADICATING_BULLET, 99 } })
end

return itemObject
