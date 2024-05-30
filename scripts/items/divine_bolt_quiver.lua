-----------------------------------
-- ID: 6427
-- Divine Volt Quiver
-- When used, you will obtain one stack of Divine Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DIVINE_BOLT, 99 } })
end

return itemObject
