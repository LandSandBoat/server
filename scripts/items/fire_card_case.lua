-----------------------------------
-- ID: 5402
-- Fire Card Case
-- When used, you will obtain one stack of Fire Cards
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.FIRE_CARD, 99 } })
end

return itemObject
