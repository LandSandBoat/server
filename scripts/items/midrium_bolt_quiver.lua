-----------------------------------
-- ID: 6139
-- Item: Mid. Bolt Quiver
-- When used, you will obtain one stack of Midrium Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.MIDRIUM_BOLT, 99 } })
end

return itemObject
