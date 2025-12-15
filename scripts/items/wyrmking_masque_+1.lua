-----------------------------------
-- ID: 25658
-- Wyrmking Masque +1
-- Dispense: Flarelet x99
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.FLARELET, 99 } })
end

return itemObject
