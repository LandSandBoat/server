-----------------------------------
-- ID: 6306
-- Item: Hap. Sh. Pouch
-- When used, you will obtain one stack of Happo Shurikens
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.HAPPO_SHURIKEN, 99 } })
end

return itemObject
