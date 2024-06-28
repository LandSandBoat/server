-----------------------------------
-- ID: 6414
-- Porxie Quiver
-- When used, you will obtain one stack of Porxie Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.PORXIE_ARROW, 99 } })
end

return itemObject
