-----------------------------------
-- ID: 5416
-- Steel Bullet Pouch
-- When used, you will obtain one stack of Steel Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.STEEL_BULLET, 99 } })
end

return itemObject
