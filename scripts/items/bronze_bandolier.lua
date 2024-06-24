-----------------------------------
-- ID: 15926
-- Bronze Bandolier
-- When used, you will obtain one stack of Bronze Bullets
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BRONZE_BULLET, 99 } })
end

return itemObject
