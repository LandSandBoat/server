-----------------------------------
-- ID: 15957
-- Iron Musketeer's Quiver
-- When used, you will obtain one Iron Musketeer's Bolt
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.IRON_MUSKETEERS_BOLT, 1 } })
end

return itemObject
