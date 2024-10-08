-----------------------------------
-- ID: 26272
-- Super Reraiser Tank
-- When used, you will obtain one super reraiser
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SUPER_RERAISER, 1 } })
end

return itemObject
