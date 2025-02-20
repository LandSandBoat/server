-----------------------------------
-- ID: 5288
-- Cluster of fleeting memories
-- Turn into a stack of fleeting memories
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.FLEETING_MEMORY, 12 } })
end

return itemObject
