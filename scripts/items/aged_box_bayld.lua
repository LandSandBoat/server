-----------------------------------
-- ID: 6267
-- Item: Aged Box (Bayld)
-- When used, you will obtain 3-15 H-P Bayld
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.PINCH_OF_HIGH_PURITY_BAYLD, math.random(3, 15) } })
end

return itemObject
