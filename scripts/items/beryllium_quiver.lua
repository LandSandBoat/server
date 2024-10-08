-----------------------------------
-- ID: 6418
-- Beryllium Quiver
-- When used, you will obtain one stack of Beryllium Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BERYLLIUM_ARROW, 99 } })
end

return itemObject
