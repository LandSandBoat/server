-----------------------------------
-- ID: 5736
-- Lin. Purse (Alx.)
-- Breaks up a Linen Purse
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ALEXANDRITE, math.randomInt(50, 99) } })
end

return itemObject
