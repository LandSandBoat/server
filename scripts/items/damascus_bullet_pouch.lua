-----------------------------------
-- ID: 6143
-- Dm. Bul. Pouch
-- When used, you will obtain one stack of Damascus Bullets
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DAMASCUS_BULLET, 99 } })
end

return itemObject
