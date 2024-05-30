-----------------------------------
-- ID: 5865
-- Toolbag Ryuno
-- When used, you will obtain one stack of ryuno
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.RYUNO, 99 } })
end

return itemObject
