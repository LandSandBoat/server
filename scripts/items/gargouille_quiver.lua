-----------------------------------
-- ID: 5912
-- Gargouille Quiver
-- When used, you will obtain one stack of Gargouille Arrow
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.GARGOUILLE_ARROW, 99 } })
end

return itemObject
