-----------------------------------
-- ID: 5868
-- Toolbag Shika
-- When used, you will obtain one stack of shikanofuda
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SHIKANOFUDA, 99 } })
end

return itemObject
