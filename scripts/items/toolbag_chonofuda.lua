-----------------------------------
-- ID: 5869
-- Toolbag Cho
-- When used, you will obtain one stack of chonofuda
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.CHONOFUDA, 99 } })
end

return itemObject
