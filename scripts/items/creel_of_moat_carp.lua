-----------------------------------
-- ID: 5810
-- Item: Creel of Moat Carp
-- When used, you will obtain 6-12 Moat Carp
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.MOAT_CARP, math.random(6, 12) } })
end

return itemObject
