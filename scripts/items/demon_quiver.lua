-----------------------------------
-- ID: 4224
-- Demon Quiver
-- When used, you will obtain one stack of Demon Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DEMON_ARROW, 99 } })
end

return itemObject
