-----------------------------------
-- ID: 5332
-- Kabura Quiver
-- When used, you will obtain one stack of Kabura Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.KABURA_ARROW, 99 } })
end

return itemObject
