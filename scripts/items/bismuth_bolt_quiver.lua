-----------------------------------
-- ID: 6206
-- Item: Bi. Bolt Quiver
-- When used, you will obtain one stack of Bismuth Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BISMUTH_BOLT, 99 } })
end

return itemObject
