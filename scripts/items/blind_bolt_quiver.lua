-----------------------------------
-- ID: 5334
-- Item: Blind Bolt Quiver
-- When used, you will obtain one stack of Blind Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BLIND_BOLT, 99 } })
end

return itemObject
