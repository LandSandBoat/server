-----------------------------------
-- ID: 4197
-- rusty_bolt_case
-- When used, you will obtain one partial stack of Rusty Bolts
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.RUSTY_BOLT, math.randomInt(10, 20) } })
end

return itemObject
