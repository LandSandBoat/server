-----------------------------------
-- ID: 6269
-- Eminent Quiver
-- When used, you will obtain one stack of Eminent Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.EMINENT_ARROW, 99 } })
end

return itemObject
