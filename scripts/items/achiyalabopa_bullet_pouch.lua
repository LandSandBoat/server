-----------------------------------
-- ID: 6207
-- Al. Bull. Pouch
-- When used, you will obtain one stack of Achiyalabopa Bullets
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ACHIYALABOPA_BULLET, 99 } })
end

return itemObject
