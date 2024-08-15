-----------------------------------
-- ID: 4105
-- Ice Cluster
-- Turn into a stack of ice crystals
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ICE_CRYSTAL, 12 } })
end

return itemObject
