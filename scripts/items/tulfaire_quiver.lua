-----------------------------------
-- ID: 6201
-- Tulfaire Quiver
-- When used, you will obtain one stack of Tulfaire Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.TULFAIRE_ARROW, 99 } })
end

return itemObject
