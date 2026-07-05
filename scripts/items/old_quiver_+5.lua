-----------------------------------
-- ID: 5275
-- Old Quiver +5
-- When used, you will obtain one partial stack of Crude Arrows +5
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.CRUDE_ARROW_P5, math.randomInt(10, 20) } })
end

return itemObject
