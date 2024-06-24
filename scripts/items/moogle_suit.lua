-----------------------------------
-- ID: 10250
-- Moogle Suit
-- Dispense: Mog Missile
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.MOG_MISSILE, 1 } })
end

return itemObject
