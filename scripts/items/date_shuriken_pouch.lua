-----------------------------------
-- ID: 6449
-- Date Suriken Pouch
-- A small leather pouch made for storing Date Suriken.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DATE_SHURIKEN, 99 } })
end

return itemObject
