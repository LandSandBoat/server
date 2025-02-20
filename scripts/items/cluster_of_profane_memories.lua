-----------------------------------
-- ID: 5289
-- Cluster of profane memories
-- Turn into a stack of profane memories
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.PROFANE_MEMORY, 12 } })
end

return itemObject
