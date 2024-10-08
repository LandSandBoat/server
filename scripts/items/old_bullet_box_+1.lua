-----------------------------------
-- ID: 5285
-- Old Bullet Box +1
-- When used, you will obtain one partial stack of Antique Bullets +1
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ANTIQUE_BULLET_P1, math.random(10, 20) } })
end

return itemObject
