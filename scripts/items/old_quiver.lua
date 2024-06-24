-----------------------------------
-- ID: 5270
-- Old Quiver
-- When used, you will obtain one partial stack of Crude Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.CRUDE_ARROW, math.random(10, 20) } })
end

return itemObject
