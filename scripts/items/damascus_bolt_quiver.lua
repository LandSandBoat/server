-----------------------------------
-- ID: 6140
-- Item: Dm. Bolt Quiver
-- When used, you will obtain one stack of Damascus Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DAMASCUS_BOLT, 99 } })
end

return itemObject
