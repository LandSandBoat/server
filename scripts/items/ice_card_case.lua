-----------------------------------
-- ID: 5403
-- Ice Card Case
-- When used, you will obtain one stack of Ice Cards
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ICE_CARD, 99 } })
end

return itemObject
