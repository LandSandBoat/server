-----------------------------------
-- ID: 4196
-- Rotten Quiver
-- When used, you will obtain one partial stack of Old Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.OLD_ARROW, math.randomInt(10, 20) } })
end

return itemObject
