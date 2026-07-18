-----------------------------------
-- ID: 6200
-- Adlivun Quiver
-- When used, you will obtain one stack of Adlivun Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ADLIVUN_ARROW, 99 } })
end

return itemObject
