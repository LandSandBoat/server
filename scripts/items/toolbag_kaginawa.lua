-----------------------------------
-- ID: 5316
-- Toolbag Kagi
-- When used, you will obtain one stack of kaginawa
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.KAGINAWA, 99 } })
end

return itemObject
