-----------------------------------
-- ID: 6304
-- Item: Rop. Sh. Pouch
-- When used, you will obtain one stack of Roppo Shurikens
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ROPPO_SHURIKEN, 99 } })
end

return itemObject
