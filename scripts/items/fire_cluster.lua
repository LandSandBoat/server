-----------------------------------
-- ID: 4104
-- Fire Cluster
-- Turn into a stack of fire crystals
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.FIRE_CRYSTAL, 12 } })
end

return itemObject
