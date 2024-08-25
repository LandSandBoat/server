-----------------------------------
-- ID: 20953
-- Escritorio
-- Dispense: Cone Calamary
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.CONE_CALAMARY, 1 } })
end

return itemObject
