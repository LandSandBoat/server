-----------------------------------
-- ID: 5910
-- Heavy Metal Pouch
-- Breaks up a Heavy Metal Pouch
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.PLATE_OF_HEAVY_METAL, math.random(3, 19) } })
end

return itemObject
