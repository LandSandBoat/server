-----------------------------------
-- ID: 6184
-- Beitetsu Box
-- Breaks up a Beitetsu Box
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BEITETSU, math.random(15, 30) } })
end

return itemObject
