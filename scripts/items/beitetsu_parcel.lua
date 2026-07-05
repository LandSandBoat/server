-----------------------------------
-- ID: 6181
-- Beitetsu Parcel
-- Breaks up a Beitetsu Parcel
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BEITETSU, math.randomInt(3, 15) } })
end

return itemObject
