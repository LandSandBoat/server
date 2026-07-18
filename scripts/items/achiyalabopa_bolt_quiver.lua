-----------------------------------
-- ID: 6203
-- Item: Al. Bolt Quiver
-- When used, you will obtain one stack of Achiyalabopa Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ACHIYALABOPA_BOLT, 99 } })
end

return itemObject
