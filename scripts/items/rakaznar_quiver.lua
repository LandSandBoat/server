-----------------------------------
-- ID: 6280
-- Ra'Kaznar Quiver
-- When used, you will obtain one stack of Ra'Kaznar Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.RAKAZNAR_ARROW, 99 } })
end

return itemObject
