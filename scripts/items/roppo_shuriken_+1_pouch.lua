-----------------------------------
-- ID: 6305
-- Item: Ro. Sh. +1 Pouch
-- When used, you will obtain one stack of Roppo Shurikens +1
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ROPPO_SHURIKEN_P1, 99 } })
end

return itemObject
