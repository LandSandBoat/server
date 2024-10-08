-----------------------------------
-- ID: 5913
-- Adaman Bolt Quiver
-- When used, you will obtain one stack of Adaman Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ADAMAN_BOLT, 99 } })
end

return itemObject
