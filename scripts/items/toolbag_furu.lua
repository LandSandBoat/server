-----------------------------------
-- ID: 6266
-- Toolbag Furu
-- When used, you will obtain one stack of Furusumi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.FURUSUMI, 99 } })
end

return itemObject
