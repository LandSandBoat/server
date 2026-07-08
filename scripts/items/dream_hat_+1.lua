-----------------------------------
-- ID: 15179
-- Dream Hat +1
-- Dispenses Ginger Cookies
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.GINGER_COOKIE, math.randomInt(1, 10) } })
end

return itemObject
