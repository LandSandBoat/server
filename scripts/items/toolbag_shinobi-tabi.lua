-----------------------------------
-- ID: 5319
-- Toolbag Shinobi-tabi
-- When used, you will obtain one stack of Shinobi-tabi
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SHINOBI_TABI, 99 } })
end

return itemObject
