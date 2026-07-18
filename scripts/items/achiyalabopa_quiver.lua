-----------------------------------
-- ID: 6199
-- Achiyal. Quiver
-- When used, you will obtain one stack of Achiyalabopa Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ACHIYALABOPA_ARROW, 99 } })
end

return itemObject
