-----------------------------------
-- ID: 5281
-- Old Bolt Box +3
-- When used, you will obtain one partial stack of Dogbolt +3
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DOGBOLT_P3, math.randomInt(10, 20) } })
end

return itemObject
