-----------------------------------
-- ID: 4110
-- Light Cluster
-- Turn into a stack of light crystals
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.LIGHT_CRYSTAL, 12 } })
end

return itemObject
