-----------------------------------
-- ID: 6202
-- Raaz Quiver
-- When used, you will obtain one stack of Raaz Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.RAAZ_ARROW, 99 } })
end

return itemObject
