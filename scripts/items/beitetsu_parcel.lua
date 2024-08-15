-----------------------------------
-- ID: 6181
-- Beitetsu Parcel
-- Breaks up a Beitetsu Parcel
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BEITETSU, math.random(3, 15) } })
end

return itemObject
