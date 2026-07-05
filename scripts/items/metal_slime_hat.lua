-----------------------------------
-- ID: 27727
-- Item: Metal Slime Hat
-- Dispense: Metal Slime Candy
-- TODO: Add hidden set effect
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.METAL_SLIME_CANDY, math.randomInt(5, 12) } })
end

return itemObject
