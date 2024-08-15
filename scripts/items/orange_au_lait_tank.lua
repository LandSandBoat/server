-----------------------------------
--  ID: 16223
--  Orange au lait Tank
--  When used, you will obtain one Orange au lait
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.FLASK_OF_ORANGE_AU_LAIT, 1 } })
end

return itemObject
