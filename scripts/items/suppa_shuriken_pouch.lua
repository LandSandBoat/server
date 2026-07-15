-----------------------------------
-- ID: 6309
-- Item: Sup. Sh. Pouch
-- When used, you will obtain one stack of Suppa Shurikens
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SUPPA_SHURIKEN, 99 } })
end

return itemObject
