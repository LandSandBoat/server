-----------------------------------
-- ID: 4106
-- Wind Cluster
-- Turn into a stack of wind crystals
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.WIND_CRYSTAL, 12 } })
end

return itemObject
