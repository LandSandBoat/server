-----------------------------------
-- ID: 5272
-- Old Quiver +2
-- When used, you will obtain one partial stack of Crude Arrows +2
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.CRUDE_ARROW_P2, math.randomInt(10, 20) } })
end

return itemObject
