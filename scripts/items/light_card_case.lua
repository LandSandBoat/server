-----------------------------------
-- ID: 5408
-- Light Card Case
-- When used, you will obtain one stack of Light Cards
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.LIGHT_CARD, 99 } })
end

return itemObject
