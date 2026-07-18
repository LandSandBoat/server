-----------------------------------
-- ID: 6271
-- Em. Bul. Pouch
-- When used, you will obtain one stack of Eminent Bullets
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.EMINENT_BULLET, 99 } })
end

return itemObject
