-----------------------------------
-- ID: 6185
-- Boulder Box
-- Breaks up a Boulder Box
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.RIFTBORN_BOULDER, math.randomInt(15, 30) } })
end

return itemObject
