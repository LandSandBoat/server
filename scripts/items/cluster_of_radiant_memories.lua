-----------------------------------
-- ID: 5292
-- Cluster of radiant memories
-- Turn into a stack of radiant memories
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.RADIANT_MEMORY, 12 } })
end

return itemObject
