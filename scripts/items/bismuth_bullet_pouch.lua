-----------------------------------
-- ID: 6210
-- Bi. Bull. Pouch
-- When used, you will obtain one stack of Bismuth Bullets
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BISMUTH_BULLET, 99 } })
end

return itemObject
