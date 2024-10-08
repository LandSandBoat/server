-----------------------------------
-- ID: 6302
-- Item: Fuma Sh. Pouch
-- When used, you will obtain one stack of Fuma Shurikens
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.FUMA_SHURIKEN, 99 } })
end

return itemObject
