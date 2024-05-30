-----------------------------------
-- ID: 14535
-- onnagimi_yukata
-- Dispense: Datechochin x99
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DATECHOCHIN, 99 } })
end

return itemObject
