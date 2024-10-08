-----------------------------------
-- ID: 6419
-- Raetic Quiver
-- When used, you will obtain one stack of Raetic Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.RAETIC_ARROW, 99 } })
end

return itemObject
