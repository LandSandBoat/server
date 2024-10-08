-----------------------------------
-- ID: 4225
-- Iron Quiver
-- When used, you will obtain one stack of Iron Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.IRON_ARROW, 99 } })
end

return itemObject
