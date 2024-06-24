-----------------------------------
-- ID: 10253
-- Decennial Coat +1
-- Dispense: Bowl of Moogurt
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BOWL_OF_MOOGURT, 1 } })
end

return itemObject
