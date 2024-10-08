-----------------------------------
-- ID: 6299
-- Item: Sh. Pouch
-- When used, you will obtain one stack of Shurikens
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SHURIKEN, 99 } })
end

return itemObject
