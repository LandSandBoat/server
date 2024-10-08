-----------------------------------
-- ID: 15300
-- nebimonite_belt
-- Dispense: Nebimonite
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.NEBIMONITE, 1 } })
end

return itemObject
