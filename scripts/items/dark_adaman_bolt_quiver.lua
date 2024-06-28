-----------------------------------
-- ID: 5872
-- Dark Adaman Bolt Quiver
-- When used, you will obtain one stack of Dark Adaman Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DARK_ADAMAN_BOLT, 99 } })
end

return itemObject
