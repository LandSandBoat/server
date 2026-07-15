-----------------------------------
-- ID: 6307
-- Item: Ha. Sh. +1 Pouch
-- When used, you will obtain one stack of Happo Shurikens +1
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.HAPPO_SHURIKEN_P1, 99 } })
end

return itemObject
