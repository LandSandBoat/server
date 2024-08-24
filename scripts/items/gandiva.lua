-----------------------------------
-- ID: 19468
-- Item: Gandiva
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getFreeSlotsCount() == 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ARTEMIS_ARROW, 99 } }) -- Artemis' Arrow x99
end

return itemObject
