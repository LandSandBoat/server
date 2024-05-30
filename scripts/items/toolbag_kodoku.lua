-----------------------------------
-- ID: 5318
-- Toolbag Kodo
-- When used, you will obtain one stack of Kodo
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.KODOKU, 99 } })
end

return itemObject
