-----------------------------------
-- ID: 13684
-- Potion Tank
-- When used, you will obtain one Potion
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.POTION, 1 } })
end

return itemObject
