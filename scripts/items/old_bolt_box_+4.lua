-----------------------------------
-- ID: 5282
-- Old Bolt Box +4
-- When used, you will obtain one partial stack of Dogbolt +4
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DOGBOLT_P4, math.random(10, 20) } })
end

return itemObject
