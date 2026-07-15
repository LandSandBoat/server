-----------------------------------
-- ID: 6308
-- Item: Hac. Sh. Pouch
-- When used, you will obtain one stack of Hachiya Shurikens
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.HACHIYA_SHURIKEN, 99 } })
end

return itemObject
