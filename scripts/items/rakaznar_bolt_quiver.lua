-----------------------------------
-- ID: 6281
-- Item: Ra. Bolt Quiver
-- When used, you will obtain one stack of Ra'Kaznar Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.RAKAZNAR_BOLT, 99 } })
end

return itemObject
