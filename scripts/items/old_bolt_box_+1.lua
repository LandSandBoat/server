-----------------------------------
-- ID: 5279
-- Old Bolt Box +1
-- When used, you will obtain one partial stack of Dogbolt +1
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DOGBOLT_P1, math.random(10, 20) } })
end

return itemObject
