-----------------------------------
-- ID: 6205
-- Item: T. Bolt Quiver
-- When used, you will obtain one stack of Titanium Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.TITANIUM_BOLT, 99 } })
end

return itemObject
