-----------------------------------
-- ID: 5286
-- Cluster of burning memories
-- Turn into a stack of burning memories
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BURNING_MEMORY, 12 } })
end

return itemObject
