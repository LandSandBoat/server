-----------------------------------
-- ID: 6282
-- Ra. Bul. Pouch
-- When used, you will obtain one stack of Ra'Kaznar Bullets
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.RAKAZNAR_BULLET, 99 } })
end

return itemObject
