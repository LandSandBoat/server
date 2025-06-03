-----------------------------------
-- ID: 27756
-- Item: Slime Cap
-- Dispense: Slimeulation Candy
-- TODO: Add hidden set effect
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SLIMEULATION_CANDY, math.random(5, 12) } })
end

return itemObject
