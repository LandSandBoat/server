-----------------------------------
-- ID: 6310
-- Item: Gash. Bolt Quiver
-- When used, you will obtain one stack of Gashing Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.GASHING_BOLT, 99 } })
end

return itemObject
