-----------------------------------
-- ID: 25775
-- Fancy Top
-- Dispenses Persikos Snow Cone
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.PERSIKOS_SNOW_CONE, 1 } })
end

return itemObject
