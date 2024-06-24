-----------------------------------
-- ID: 5819
-- Item: Antlion Quiver
-- When used, you will obtain one stack of Antlion Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ANTLION_ARROW, 99 } })
end

return itemObject
