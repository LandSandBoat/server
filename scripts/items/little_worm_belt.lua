-----------------------------------
-- ID: 15454
-- little_worm_belt
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.LITTLE_WORM, 12 } })
end

return itemObject
