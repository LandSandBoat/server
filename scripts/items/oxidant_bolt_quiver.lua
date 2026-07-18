-----------------------------------
-- ID: 6141
-- Item: O. Bolt Quiver
-- When used, you will obtain one stack of Oxidant Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.OXIDANT_BOLT, 99 } })
end

return itemObject
