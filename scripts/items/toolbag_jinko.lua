-----------------------------------
-- ID: 5864
-- Toolbag Jinko
-- When used, you will obtain one stack of jinko
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.JINKO, 99 } })
end

return itemObject
