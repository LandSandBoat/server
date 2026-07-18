-----------------------------------
-- ID: 6279
-- Item: Rig. Bolt Quiver
-- When used, you will obtain one stack of Righteous Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.RIGHTEOUS_BOLT, 99 } })
end

return itemObject
