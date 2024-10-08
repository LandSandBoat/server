-----------------------------------
-- ID: 16120
-- redeyes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ANGELWING, 99 } }) -- Angelwing x99
end

return itemObject
