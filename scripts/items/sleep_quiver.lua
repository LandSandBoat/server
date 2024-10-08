-----------------------------------
-- ID: 5333
-- Sleep Quiver
-- When used, you will obtain one stack of Sleep Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SLEEP_ARROW, 99 } })
end

return itemObject
