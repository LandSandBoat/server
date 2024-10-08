-----------------------------------
-- ID: 5407
-- Water Card Case
-- When used, you will obtain one stack of Water Cards
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.WATER_CARD, 99 } })
end

return itemObject
