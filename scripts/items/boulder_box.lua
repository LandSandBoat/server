-----------------------------------
-- ID: 6185
-- Boulder Box
-- Breaks up a Boulder Box
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.RIFTBORN_BOULDER, math.random(15, 30) } })
end

return itemObject
