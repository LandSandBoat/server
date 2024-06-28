-----------------------------------
-- ID: 5821
-- Fusion Bolt Quiver
-- When used, you will obtain one stack of Fusion Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.FUSION_BOLT, 99 } })
end

return itemObject
