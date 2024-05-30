-----------------------------------
-- ID: 5734
-- Toolbag Soshi
-- When used, you will obtain one stack of soshi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SOSHI, 99 } })
end

return itemObject
