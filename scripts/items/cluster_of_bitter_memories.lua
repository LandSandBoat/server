-----------------------------------
-- ID: 5287
-- Cluster of bitter memories
-- Turn into a stack of bitter memories
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BITTER_MEMORY, 12 } })
end

return itemObject
