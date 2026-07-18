-----------------------------------
-- ID: 6208
-- Ad. Bull. Pouch
-- When used, you will obtain one stack of Adlivun Bullets
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ADLIVUN_BULLET, 99 } })
end

return itemObject
