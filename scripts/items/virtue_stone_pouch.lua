-----------------------------------
-- ID: 5410
-- virtue_stone_pouch.lua
-- When used, you will obtain one stack of virtue stone
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.VIRTUE_STONE, 99 } })
end

return itemObject
