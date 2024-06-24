-----------------------------------
-- Trump Card Case
-- Lua By Reefed406
-- ItemID : 5870
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.TRUMP_CARD, 99 } })
end

return itemObject
