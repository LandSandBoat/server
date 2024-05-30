-----------------------------------
-- ID: 15927
-- pinwheel_belt
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.PINWHEEL, 99 } }) -- pinwheel
end

return itemObject
