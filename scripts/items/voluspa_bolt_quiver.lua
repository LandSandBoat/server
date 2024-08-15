-----------------------------------
-- ID: 6429
-- Voluspa Volt Quiver
-- When used, you will obtain one stack of Voluspa Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.VOLUSPA_BOLT, 99 } })
end

return itemObject
