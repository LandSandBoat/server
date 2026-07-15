-----------------------------------
-- ID: 6303
-- Item: Iga Sh. Pouch
-- When used, you will obtain one stack of Iga Shurikens
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.IGA_SHURIKEN, 99 } })
end

return itemObject
