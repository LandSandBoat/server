-----------------------------------
-- ID: 5290
-- Cluster of startling memories
-- Turn into a stack of startling memories
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.STARTLING_MEMORY, 12 } })
end

return itemObject
