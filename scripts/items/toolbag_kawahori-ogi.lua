-----------------------------------
-- ID: 5310
-- Toolbag Kawa
-- When used, you will obtain one stack of kawahori-ogi
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.KAWAHORI_OGI, 99 } })
end

return itemObject
