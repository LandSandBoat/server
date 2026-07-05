-----------------------------------
-- ID: 5284
-- Old Bullet Box
-- When used, you will obtain one partial stack of Antique Bullets
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ANTIQUE_BULLET, math.randomInt(10, 20) } })
end

return itemObject
