-----------------------------------
--   ID: 15288
--   Pellet Belt
--   When used, you will obtain 12 Pebbles
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.PEBBLE, 12 } })
end

return itemObject
