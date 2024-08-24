-----------------------------------
-- ID: 5353
-- Iron Bullet Pouch
-- When used, you will obtain one stack of Iron Bullets
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.IRON_BULLET, 99 } })
end

return itemObject
