-----------------------------------
-- ID: 10812
-- Item: Chocobo Shield +1
-- Dispense: Sakura Biscuit
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SAKURA_BISCUIT, 1 } })
end

return itemObject
