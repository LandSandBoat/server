-----------------------------------
-- ID: 5735
-- Ctn. Purse (Alx.)
-- Breaks up a Cotton Purse
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ALEXANDRITE, math.randomInt(5, 20) } })
end

return itemObject
