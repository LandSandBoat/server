-----------------------------------
-- ID: 6420
-- Voluspa Quiver
-- When used, you will obtain one stack of Voluspa Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.VOLUSPA_ARROW, 99 } })
end

return itemObject
