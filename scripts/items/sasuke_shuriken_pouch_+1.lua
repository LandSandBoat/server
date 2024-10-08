-----------------------------------
-- ID: 6448
-- Sasu. Sh. Pouch +1
-- A small leather pouch made for storing sasuke shuriken +1.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SASUKE_SHURIKEN_P1, 99 } })
end

return itemObject
