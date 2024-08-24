-----------------------------------
-- ID: 5336
-- Holy Bolt Quiver
-- When used, you will obtain one stack of Holy Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.HOLY_BOLT, 99 } })
end

return itemObject
