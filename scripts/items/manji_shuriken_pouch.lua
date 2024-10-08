-----------------------------------
-- ID: 6298
-- Item: Manji Shr. Pouch
-- When used, you will obtain one stack of Manji Shurikens
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.MANJI_SHURIKEN, 99 } })
end

return itemObject
