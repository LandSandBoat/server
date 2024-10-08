-----------------------------------
-- ID: 5314
-- Toolbag Shihei
-- When used, you will obtain one stack of Shihei
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SHIHEI, 99 } })
end

return itemObject
