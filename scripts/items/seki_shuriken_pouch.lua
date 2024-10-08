-----------------------------------
-- ID: 6415
-- Seki Shuriken Pouch
-- When used, you will obtain one stack of Seki Shurikens
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SEKI_SHURIKEN, 99 } })
end

return itemObject
