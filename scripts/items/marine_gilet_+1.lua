-----------------------------------
-- ID: 10264
-- Marine Gilet +1
-- Dispense: Berry Snowcone
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BERRY_SNOW_CONE, 1 } })
end

return itemObject
