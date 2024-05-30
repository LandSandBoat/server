-----------------------------------
-- ID: 13682
-- Ether Tank
-- When used, you will obtain one Ether
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ETHER, 1 } })
end

return itemObject
