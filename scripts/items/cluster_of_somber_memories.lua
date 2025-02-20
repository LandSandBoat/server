-----------------------------------
-- ID: 5291
-- Cluster of somber memories
-- Turn into a stack of somber memories
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SOMBER_MEMORY, 12 } })
end

return itemObject
