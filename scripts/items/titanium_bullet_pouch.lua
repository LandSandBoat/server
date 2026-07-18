-----------------------------------
-- ID: 6209
-- Ti. Bull. Pouch
-- When used, you will obtain one stack of Titanium Bullets
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.TITANIUM_BULLET, 99 } })
end

return itemObject
