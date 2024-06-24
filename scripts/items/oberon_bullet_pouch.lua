-----------------------------------
-- ID: 5822
-- Oberon Bullet Pouch
-- When used, you will obtain one stack of Oberon Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.OBERON_BULLET, 99 } })
end

return itemObject
