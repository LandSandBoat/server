-----------------------------------
-- ID: 4223
-- Scorpion Quiver
-- When used, you will obtain one stack of Scorpion Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SCORPION_ARROW, 99 } })
end

return itemObject
