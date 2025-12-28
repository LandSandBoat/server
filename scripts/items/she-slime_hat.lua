-----------------------------------
-- ID: 27726
-- Item: She-Slime Hat
-- Dispense: She-Slime Candy
-- TODO: Add hidden set effect
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SHE_SLIME_CANDY, math.random(5, 12) } })
end

return itemObject
