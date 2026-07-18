-----------------------------------
-- ID: 6270
-- Item: Em. Bolt Quiver
-- When used, you will obtain one stack of Eminent Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.EMINENT_BOLT, 99 } })
end

return itemObject
