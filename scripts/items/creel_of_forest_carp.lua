-----------------------------------
-- ID: 5811
-- Item: Creel of Forest Carp
-- When used, you will obtain 6-12 Forest Carp
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.FOREST_CARP, math.random(6, 12) } })
end

return itemObject
