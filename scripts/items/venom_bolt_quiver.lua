-----------------------------------
-- ID: 5338
-- Venom Bolt Quiver
-- When used, you will obtain one stack of Venom Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.VENOM_BOLT, 99 } })
end

return itemObject
